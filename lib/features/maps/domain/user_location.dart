import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:tracker_app/core/app_setup/hive/hive_box.dart';
part 'user_location.freezed.dart';
part 'user_location.g.dart';

@freezed
class UserLocation with _$UserLocation {
  @HiveType(typeId: HiveBox.locationHiveId)
  const factory UserLocation({
    @HiveField(0) double? latitude,
    @HiveField(1) double? longitude,
    @HiveField(2) DateTime? timestamp,
  }) = _UserLocation;

  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _$UserLocationFromJson(json);
}
