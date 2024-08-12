import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';
import 'package:tracker_app/features/maps/domain/user_location.dart';

abstract class LocationRepo {
  Future<UserLocation> getCurrentLocation();
  Future<void> listenLocation(bool listenStatus);
  Future<void> stopListeningLocation();
  Stream<Iterable<UserLocation>> getUserLocationHistory(); // Add this line
}

class LocationRepoImpl extends LocationRepo {
  LocationRepoImpl({
    required this.ref,
  });
  final Logger _logger = Logger('Location');

  late StreamSubscription<Position> positionStream;
  UserLocation? userLocation;
  Ref ref;

  @override
  Future<UserLocation> getCurrentLocation() async {
    try {
      // Determine the current position
      final Position position = await _determinePosition();

      // Fetch the most recent location from Firestore
      final remoteLocationSnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('Location')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      // Check if there is a previous location stored
      UserLocation? previousLocation;
      if (remoteLocationSnapshot.docs.isNotEmpty) {
        previousLocation =
            UserLocation.fromJson(remoteLocationSnapshot.docs.first.data());
        log('TimeStamp of previous location: ${previousLocation.timestamp}');
      }

      // If the current location is different from the last stored location, update Firestore
      if (previousLocation == null ||
          previousLocation.latitude != position.latitude ||
          previousLocation.longitude != position.longitude) {
        final userLocation = UserLocation(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: DateTime.now(),
        );

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('Location')
            .add(userLocation.toJson());

        log('Location updated to Firestore: lat=${position.latitude}, lon=${position.longitude}');
        return userLocation;
      } else {
        log('Location already exists in Firestore.');
        return previousLocation;
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to get current location: $e', e, stackTrace);
      rethrow;
    }
  }

  @override
  Stream<Iterable<UserLocation>> getUserLocationHistory() {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Location')
        .snapshots()
        .map(
          (event) =>
              event.docChanges.map((e) => UserLocation.fromJson(e.doc.data()!)),
        );
  }

  Future<Position> _determinePosition() async {
    try {
      // if (!isLocationServiceEnabled) {
      //   throw Exception('Location services are disabled.');
      // }

      final LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final LocationPermission newPermission =
            await Geolocator.requestPermission();
        if (newPermission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      } else if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }
      return await Geolocator.getCurrentPosition();
    } catch (e, stackTrace) {
      _logger.severe('Error determining position: $e', e, stackTrace);
      rethrow; // Rethrow the error to propagate it to the caller.
    }
  }

  @override
  Future<void> listenLocation(bool listenStatus) async {
    try {
      LocationSettings locationSettings;
      if (defaultTargetPlatform == TargetPlatform.android &&
          await Geolocator.requestPermission() == LocationPermission.always) {
        locationSettings = AndroidSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 100,
            forceLocationManager: true,
            intervalDuration: const Duration(seconds: 100),
            foregroundNotificationConfig: const ForegroundNotificationConfig(
              notificationText:
                  "Example app will continue to receive your location even when you aren't using it",
              notificationTitle: "Running in Background",
              enableWakeLock: true,
            ));
      } else if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS) {
        locationSettings = AppleSettings(
          accuracy: LocationAccuracy.high,
          activityType: ActivityType.fitness,
          distanceFilter: 100,
          pauseLocationUpdatesAutomatically: true,
          // Only set to true if our app will be started up in the background.
          showBackgroundLocationIndicator: false,
        );
      } else {
        await Geolocator.requestPermission();
        locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        );
      }

      positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position position) async {
        userLocation = UserLocation(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: DateTime.now(),
        );
        log('${position.latitude}, ${position.longitude}');
        // update location to firebase
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('Location')
            .add(userLocation!.toJson())
            .whenComplete(() async {
          _logger.info(
              'Got current location: lat=${userLocation?.latitude}, lon=${userLocation?.longitude} at ${userLocation?.timestamp}');

          log('Location has been added to database');
        }).catchError(
          (e) {
            log('Error adding location to database: $e');
            return e;
          },
        );

        _logger.info(
            'Got current location: lat=${userLocation?.latitude}, lon=${userLocation?.longitude} at ${userLocation?.timestamp}');
      });

      if (listenStatus == false) {
        await positionStream.cancel();
        _logger.info('Stopped listening location');
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to get latitude or longitude: $e', e, stackTrace);
    }
  }

  @override
  Future<void> stopListeningLocation() async {
    try {
      await positionStream.cancel();
      _logger.info('Stopped listening location');
    } catch (e, stackTrace) {
      _logger.severe('Failed to stop listening location: $e', e, stackTrace);
    }
  }
}
