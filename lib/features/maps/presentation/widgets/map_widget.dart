import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracker_app/features/maps/data/location_provider.dart';
import 'package:tracker_app/features/maps/domain/user_location.dart';

import '../../data/remote_location_repo.dart';

class MapsView extends ConsumerStatefulWidget {
  const MapsView({super.key});

  @override
  ConsumerState<MapsView> createState() => MapsViewState();
}

class MapsViewState extends ConsumerState<MapsView> {
  late GoogleMapController _controller;

  @override
  initState() {
    super.initState();
    ref.read(locationProvider).getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(startLocationListeningProvider);
    final currentLocationAsyncValue = ref.watch(currentLocationProvider);
    final locationStreamAsyncValue = ref.watch(locationStreamProvider);
    return currentLocationAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (currentLocation) {
        return locationStreamAsyncValue.when(
          loading: () => _buildMap(currentLocation),
          error: (error, stack) => Center(child: Text('Error: $error')),
          data: (locations) {
            UserLocation currentPosition = currentLocation;

            if (locations.isNotEmpty) {
              final firstLocation = locations.first;
              currentPosition = firstLocation;
            }

            return _buildMap(currentPosition);
          },
        );
      },
    );
    // return Scaffold(
    //   body: StreamBuilder<Iterable<UserLocation>>(
    //       stream: ref.read(locationProvider).getUserLocationHistory(),
    //       builder: (context, streamSnapshot) {
    //         LatLng initialPosition;
    //         if (streamSnapshot.hasData && streamSnapshot.data!.isNotEmpty) {
    //           // If the stream has data, use the first element in the stream
    //           initialPosition = LatLng(
    //             streamSnapshot.data!.first.latitude!,
    //             streamSnapshot.data!.first.longitude!,
    //           );
    //         } else {
    //           // If the stream has no data, use the current location
    //           initialPosition = LatLng(
    //             ref.read(locationProvider).userLocation?.latitude ?? 27.7172,
    //             ref.read(locationProvider).userLocation?.longitude ?? 85.3240,
    //           );
    //         }
    //         return
    //       }),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    //   floatingActionButton: FloatingActionButton.small(
    //     backgroundColor: Colors.white,
    //     heroTag: null,
    //     onPressed: _getYourLocation,
    //     child: const Icon(
    //       Icons.my_location,
    //       color: Colors.grey,
    //     ),
    //   ),
    // );
  }

  Future<Set<Marker>> generateMarkers(List<UserLocation> positions) async {
    List<Marker> markers = <Marker>[];

    for (final location in positions) {
      const icon = BitmapDescriptor.defaultMarker;

      final marker = Marker(
        markerId: MarkerId(location.toString()),
        position: LatLng(location.latitude!, location.longitude!),
        icon: icon,
      );

      markers.add(marker);
    }

    return markers.toSet();
  }

  _buildMap(UserLocation currentLocation) {
    return GoogleMap(
      myLocationEnabled: true,
      markers: {
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(
            currentLocation.latitude ?? 27.7172,
            currentLocation.longitude ?? 85.3240,
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      },
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
      mapType: MapType.normal,
      rotateGesturesEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          currentLocation.latitude ?? 27.7172,
          currentLocation.longitude ?? 85.3240,
        ),
        zoom: 14.4746,
      ),
      onMapCreated: (GoogleMapController controller) async {
        setState(() {
          _controller = controller;
        });
      },
    );
  }
}
