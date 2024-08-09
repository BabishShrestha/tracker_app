import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tracker_app/feature/user/repositories/user_repo.dart';

class Location {
  Location({
    required this.ref,
  });
  final Logger _logger = Logger('Location');

  double? latitude;
  double? longitude;

  Ref ref;

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
}
