import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tracker_app/core/app_setup/failure/failure.dart';

abstract class NotificationRepo {
  Future<Either<void, Failure>> sendNotification({
    required String title,
    required String body,
    required String subscribedTopic,
  });
}

final notificationRepoProvider = Provider<NotificationRepo>(
  (ref) => NotificationRepoImpl(ref: ref),
);
final notificationCollection = FirebaseFirestore.instance.collection('Users');

class NotificationRepoImpl extends NotificationRepo {
  NotificationRepoImpl({required Ref ref}) : _ref = ref;

  final Ref _ref;

  @override
  Future<Either<void, Failure>> sendNotification({
    required String title,
    required String body,
    required String subscribedTopic,
  }) async {
    try {
      final fcmRequest = await FirebaseMessaging.instance.requestPermission();

      if (fcmRequest.authorizationStatus == AuthorizationStatus.authorized) {
        log('Permission granted: ${fcmRequest.authorizationStatus}');

        var requestBody = {
          "message": {
            "topic": subscribedTopic,
            "notification": {"title": title, "body": body}
          }
        };
        var uri = 'https://tracker-backend-rogn.onrender.com/send-fcm-message/';
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
      } else if (fcmRequest.authorizationStatus == AuthorizationStatus.denied) {
        log('Permission not granted: ${fcmRequest.authorizationStatus}');
        // CustomSnackbar(
        //   context: context,
        //   message: 'Permission not granted',
        //   backgroundColor: UIColors.activeDotColor,
        // );
        return Right(Failure('Permission not granted', FailureType.exception));
      }

      return const Left(null);
    } catch (e) {
      log('Error sending notification: $e');
      return Right(Failure(e.toString(), FailureType.exception));
    }
  }

  // @override
  // Future<void> addNotificationToDatabase(
  //     {required NotificationModel notification}) async {
  //   try {
  //     await notificationCollection
  //         .doc(notification.message.receiverId)
  //         .collection('notifications')
  //         .doc(notification.id)
  //         .set(notification.toJson())
  //         .whenComplete(() {
  //       log('Notification added to database');
  //     }).catchError((e) {
  //       log('Error adding Notification to database: $e');
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
}
