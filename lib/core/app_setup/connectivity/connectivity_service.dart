import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/features/maps/data/location_provider.dart';
import 'package:tracker_app/features/push_noitification/data/repository/notification_repo.dart';

final connectivityServiceProvider = Provider<ConnectivityService>(
  (ref) => ConnectivityService(ref: ref),
);

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  final Ref ref;

  ConnectivityService({required this.ref});

  void startMonitoring() {
    _subscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      ConnectivityResult result = results.last;
      if (result == ConnectivityResult.none) {
        // The app is offline
        notifyStatus('offline');
      } else {
        // The app is back online
        notifyStatus('online');
      }
    });
  }

  void stopMonitoring() {
    // notifyStatus('offline');
    _subscription.cancel();
  }

  void notifyStatus(String status) {
    if (status == 'online') {
      log("The app is online");
      ref.read(notificationRepoProvider).sendNotification(
            title: 'Tracker App is online',
            body: 'The user is now available to track',
            subscribedTopic: 'tracer',
          );
    } else {
      log("The app is offline");
      ref.read(locationProvider).stopListeningLocation();
      ref.read(notificationRepoProvider).sendNotification(
            title: 'Tracker App is offline',
            body: 'The user is not available to track',
            subscribedTopic: 'tracer',
          );
    }

    log("Status changed: $status");
  }
}
