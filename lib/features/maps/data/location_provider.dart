import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tracker_app/features/maps/data/remote_location_repo.dart';
import 'package:tracker_app/features/maps/domain/user_location.dart';

part 'location_provider.g.dart';

@riverpod
LocationRepoImpl location(Ref ref) {
  return LocationRepoImpl(ref: ref);
}

@riverpod
Future<UserLocation> currentLocation(Ref ref) async {
  final locationRepository = ref.read(locationProvider);
  return await locationRepository.getCurrentLocation();
}

@riverpod
Stream<Iterable<UserLocation>> locationStream(Ref ref) {
  final locationRepository = ref.read(locationProvider);
  return locationRepository.getUserLocationHistory();
}

@riverpod
LocationRepoImpl locationListener(Ref ref) {
  ref.onDispose(() {
    ref.read(locationProvider).stopListeningLocation();
  });
  return ref.read(locationProvider);
}
