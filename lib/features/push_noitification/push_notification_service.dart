// import 'dart:convert';
// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tracker_app/core/routes/app_router.dart';
// import 'package:tracker_app/features/authentication/data/auth_repo.dart';
// import 'package:tracker_app/features/dashboard/wrapper.dart';

// @pragma('vm:entry-point')
// Future<void> handleBackgroundMessage(RemoteMessage? message) async {
//   if (message == null) return;

//   log('Background handler started');
//   log('Title: ${message.notification?.title}');
//   log('Body: ${message.notification?.body}');
//   log('Payload: ${message.data}');
//   // navigatorKey.currentState
//   //     ?.push(NotificationView.routeName, arguments: message);
// }

// class PushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;

//   final _androidChannel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.defaultImportance,
//   );
//   final _localNotification = FlutterLocalNotificationsPlugin();
//   void handleMessageForeground(RemoteMessage? message) async {
//     if (message == null) return;
//     log('Foreground handler started');
//     log('Title: ${message.notification?.title}');
//     log('Body: ${message.notification?.body}');
//     log('Payload: ${message.data}');

//     final goRouter =
//         GoRouter.of(NavigationService.navigatorKey.currentContext!);

//     bool currentRouteIsViewOrderHistory =
//         goRouter.routeInformationProvider.value.uri.toString() ==
//             '/${RoutePath.viewOrderHistory}';
//     final ref = ProviderContainer();
//     final isLoggedIn = await ref.read(authProvider).isAuthenticated();
//     log(' Push notify Is Logged In: $isLoggedIn');
//     // ? direct to page when notification is pressed
//     if (!currentRouteIsViewOrderHistory && isLoggedIn) {
//       goRouter.replace('/wrapper', extra: NavBarIndex.orderHistory.index);
//     } else {
//       goRouter.go('/');
//     }
//   }

//   Future<void> initialize() async {
//     final settings = await _fcm.requestPermission();

//     if (kDebugMode) {
//       log('Permission granted: ${settings.authorizationStatus}');
//     }
//     await getToken();
//     initLocalNotifications();
//     initPushNotifications();
//   }

//   Future<void> initLocalNotifications() async {
//     const iOS = DarwinInitializationSettings();
//     const android = AndroidInitializationSettings('@mipmap/launcher_icon');
//     const settings = InitializationSettings(android: android, iOS: iOS);

//     await _localNotification.initialize(settings,
//         onDidReceiveNotificationResponse: (payload) {
//       log('Notification Received: ${payload.payload}');
//       final message = RemoteMessage.fromMap(
//         jsonDecode(
//           payload.payload.toString(),
//         ),
//       );
//       handleMessageForeground(message);
//     });
//     final platform = _localNotification.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }

//   Future<String?> getToken() async {
//     String? token = await _fcm.getToken();
//     log('Token: $token');
//     return token;
//   }

//   Future<void> initPushNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     await FirebaseMessaging.instance.getInitialMessage().then((message) {
//       log('On Initial Message');
//       handleMessageForeground(message);
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       log('On Message Opened App');
//       handleMessageForeground(message);
//     });

//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       log('On Message');
//       if (notification == null) return;

//       _localNotification.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             _androidChannel.id,
//             _androidChannel.name,
//             channelDescription: _androidChannel.description,
//             // icon: '@mipmap/',
//             // importance: _androidChannel.importance,
//             // priority: Priority.defaultPriority,
//           ),
//         ),
//         payload: jsonEncode(
//           message.toMap(),
//         ),
//       );
//     });
//   }
// }
