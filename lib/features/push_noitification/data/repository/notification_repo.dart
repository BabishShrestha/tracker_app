import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tracker_app/core/app_setup/failure/failure.dart';
import 'package:tracker_app/features/push_noitification/domain/model/notification_model.dart';
import 'package:tracker_app/features/user/riverpod/user_provider.dart';

abstract class NotificationRepo {
  // Future<Either<void, Failure>> sendNotification(
  //     {required String title,
  //     required String body,
  //     required List<String>? tokenList});
  Future<void> addNotificationToDatabase({
    required NotificationModel notification,
  });
  Future<void> sendNotificationToAll(
      {required String title, required String body});
  // Future<Either<List<NotificationModel>, Failure>> getNotifications();
}

final notificationRepoProvider = Provider<NotificationRepo>(
  (ref) => NotificationRepoImpl(
    ref: ref,
    dioHelper: ref.read(dioHelper),
  ),
);
final notificationCollection = FirebaseFirestore.instance.collection('Users');

class NotificationRepoImpl extends NotificationRepo {
  NotificationRepoImpl({required Ref ref, required DioHelper dioHelper})
      : _ref = ref,
        _dioHelper = dioHelper;

  final Ref _ref;
  final DioHelper _dioHelper;
  get context => NavigationService.navigatorKey.currentContext;

  @override
  Future<Either<void, Failure>> sendNotification(
      {required String title,
      required String body,
      required List<String>? tokenList}) async {
    try {
      final fcmRequest = await FirebaseMessaging.instance.requestPermission();

      if (fcmRequest.authorizationStatus == AuthorizationStatus.authorized) {
        log('Permission granted: ${fcmRequest.authorizationStatus}');
        if (tokenList != null) {
          for (var token in tokenList) {
            var requestBody = {
              "message": {
                "token": token,
                "notification": {"title": title, "body": body}
              }
            };
            // TODO: add notification url
            var uri = 'enter your url for notifications. ';
            var dio = Dio();

            dio
                .post(
              uri,
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                },
                sendTimeout: const Duration(seconds: 300),
                receiveTimeout: const Duration(seconds: 300),
              ),
              data: jsonEncode(requestBody),
            )
                .whenComplete(() async {
              log('Notification sent');
              // CustomSnackbar(
              //   context: context,
              //   message: 'Notification sent successfully!!',
              //   backgroundColor: UIColors.statusGreen,
              // );
            }).catchError((e) {
              log('Error sending notification: $e');
              // CustomSnackbar(
              //   context: context,
              //   message: 'Error sending notification',
              // );
              Right(Failure(e.toString(), FailureType.exception));
            });
          }
        } else {
          log('Token list is null');
          CustomSnackbar(
            context: context,
            message: 'Token list is null',
            backgroundColor: UIColors.activeDotColor,
          );
          return Right(Failure('Token list is null', FailureType.exception));
        }
      } else if (fcmRequest.authorizationStatus == AuthorizationStatus.denied) {
        log('Permission not granted: ${fcmRequest.authorizationStatus}');
        CustomSnackbar(
          context: context,
          message: 'Permission not granted',
          backgroundColor: UIColors.activeDotColor,
        );
        return Right(Failure('Permission not granted', FailureType.exception));
      }

      log('$tokenList');
      return const Left(null);
      // log('Notification sent: ${response.body}');
    } catch (e) {
      log('Error sending notification: $e');
      return Right(Failure(e.toString(), FailureType.exception));
    }
  }

  @override
  Future<void> sendNotificationToAll(
      {required String title, required String body}) async {
    try {
      // final response = await _dioHelper.post(
      //   '/sendAll',
      //   data: {
      //     'title': title,
      //     'body': body,
      //   },
      // );
      // log('Notification sent to all: $response');
    } catch (e) {
      log('Error sending notification to all: $e');
    }
  }

  // @override
  // Future<void> addNotification(RemoteMessage message) async {
  //   try {
  //     await notificationCollection
  //         .add(
  //       NotificationModel(
  //         title: message.notification?.title ?? '',
  //         body: message.notification?.body ?? '',
  //         sentTime: DateTime.now(),
  //         senderId: message.senderId ?? '',
  //         messageId: message.messageId ?? '',
  //         messageType: message.data['type'] ?? '',
  //       ).toJson(),
  //     )
  //         .whenComplete(() {
  //       log('Notification added to database');
  //     }).catchError((e) {
  //       log('Error adding Notification to database: $e');
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  @override
  Future<Either<List<NotificationModel>, Failure>> getNotifications() async {
    try {
      final response = await notificationCollection
          .doc(_ref.read(appUserProvider).id)
          .collection('notifications')
          .get();

      final notificationList = response.docs.map((notificationItem) {
        return NotificationModel.fromJson(notificationItem.data());
      }).toList();
      log('Notifications:$notificationList');
      return Left(notificationList);
    } catch (e) {
      log('Error getting notifications: $e');
      return Right(Failure(e.toString(), FailureType.exception));
    }
  }

  @override
  Future<void> addNotificationToDatabase(
      {required NotificationModel notification}) async {
    try {
      await notificationCollection
          .doc(notification.message.receiverId)
          .collection('notifications')
          .doc(notification.id)
          .set(notification.toJson())
          .whenComplete(() {
        log('Notification added to database');
      }).catchError((e) {
        log('Error adding Notification to database: $e');
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
