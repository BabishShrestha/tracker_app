// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationHash() => r'3b9f331ba253538d0e066c17eb2f54309973e0ef';

/// See also [location].
@ProviderFor(location)
final locationProvider = AutoDisposeProvider<LocationRepoImpl>.internal(
  location,
  name: r'locationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$locationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocationRef = AutoDisposeProviderRef<LocationRepoImpl>;
String _$currentLocationHash() => r'9188ce6fedfdc7e4c8d1334dba7b3f17acc7a90b';

/// See also [currentLocation].
@ProviderFor(currentLocation)
final currentLocationProvider =
    AutoDisposeFutureProvider<UserLocation>.internal(
  currentLocation,
  name: r'currentLocationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentLocationRef = AutoDisposeFutureProviderRef<UserLocation>;
String _$locationStreamHash() => r'204f39374b5d491ff4d5dd20ff8c1c57173c7056';

/// See also [locationStream].
@ProviderFor(locationStream)
final locationStreamProvider =
    AutoDisposeStreamProvider<Iterable<UserLocation>>.internal(
  locationStream,
  name: r'locationStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocationStreamRef
    = AutoDisposeStreamProviderRef<Iterable<UserLocation>>;
String _$locationListenerHash() => r'bc7c009e199f24c7daa1cd33b702828d0c00b744';

/// See also [locationListener].
@ProviderFor(locationListener)
final locationListenerProvider = AutoDisposeProvider<LocationRepoImpl>.internal(
  locationListener,
  name: r'locationListenerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationListenerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocationListenerRef = AutoDisposeProviderRef<LocationRepoImpl>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
