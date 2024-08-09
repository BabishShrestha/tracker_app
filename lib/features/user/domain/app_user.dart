import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'package:tracker_app/core/app_setup/hive/hive_box.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  @HiveType(typeId: HiveBox.userHiveId)
  const factory AppUser({
    @HiveField(0) String? id,
    @HiveField(1) String? email,
    @JsonKey(
      includeToJson: false,
    )
    @HiveField(2)
    String? password,
    @HiveField(3) String? name,
    @HiveField(4) List<String>? deviceToken,
    @HiveField(5) double? longitude,
    @HiveField(6) double? latitude,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
