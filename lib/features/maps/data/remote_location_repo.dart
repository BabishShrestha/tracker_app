import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';
import 'package:tracker_app/features/user/repositories/user_repo.dart';

abstract class LocationRepo {
  Future<void> getCurrentLocation();
  Future<void> listenLocation();
  Future<void> stopListeningLocation();
}

class LocationRepoImpl extends LocationRepo {
  LocationRepoImpl({
    required this.ref,
  });
  final Logger _logger = Logger('Location');

  double? latitude;
  double? longitude;
  late StreamSubscription<Position> positionStream;

  Ref ref;
  @override
  Future<void> getCurrentLocation() async {
    try {
      final Position position = await _determinePosition();
      latitude = position.latitude;
      longitude = position.longitude;
      // update location to firebase
      final user = await ref
          .read(userRepoProvider)
          .getUserDetails(FirebaseAuth.instance.currentUser!.uid);
      ref.read(userRepoProvider).updateUser(
            user!.copyWith(
              latitude: latitude,
              longitude: longitude,
            ),
          );
      _logger.info('Got current location: lat=$latitude, lon=$longitude');
    } catch (e, stackTrace) {
      _logger.severe('Failed to get latitude or longitude: $e', e, stackTrace);
    }
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
  Future<void> listenLocation() async {
    try {
      positionStream =
          Geolocator.getPositionStream().listen((Position position) async {
        latitude = position.latitude;
        longitude = position.longitude;
        // update location to firebase
        final user = await ref
            .read(userRepoProvider)
            .getUserDetails(FirebaseAuth.instance.currentUser!.uid);
        ref.read(userRepoProvider).updateUser(user!.copyWith(
              latitude: latitude,
              longitude: longitude,
            ));
        _logger.info('Got current location: lat=$latitude, lon=$longitude');
      });
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
