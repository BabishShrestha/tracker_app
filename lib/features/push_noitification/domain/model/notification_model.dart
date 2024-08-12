import 'package:tracker_app/src/core/config/hive/hive_box.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  @HiveType(typeId: HiveBox.notificationHiveId) // Unique identifier for Hive
  const factory NotificationModel({
    @HiveField(0) required String id,
    @HiveField(1) required Message message,
    @HiveField(2) required DateTime createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

@freezed
class Message with _$Message {
  const factory Message({
    @HiveField(0) required Notification notification,
    @HiveField(1) required String? senderId,
    @HiveField(2) required String? receiverId,
    @HiveField(3) required String? orderId,

    // @HiveField(1) required String topic,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

@freezed
class Notification with _$Notification {
  const factory Notification({
    @HiveField(0) required String title,
    @HiveField(1) required String body,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}

// class TimestampSerializer implements JsonConverter<Timestamp, dynamic> {
//   const TimestampSerializer();

//   @override
//   Timestamp fromJson(dynamic timestamp) => timestamp;

//   @override
//   Timestamp toJson(Timestamp timestamp) => timestamp;
// }
