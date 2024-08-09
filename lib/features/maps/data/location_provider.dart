import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tracker_app/features/maps/data/remote_location_repo.dart';

part 'location_provider.g.dart';

@riverpod
Location location(Ref ref) {
  return Location(ref: ref);
}
