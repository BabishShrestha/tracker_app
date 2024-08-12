// import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/config/failure.dart';

part 'app_state.freezed.dart';

enum AppStatus { idle, busy, success, failure }

@freezed
class AppState with _$AppState {
  const AppState._();
  const factory AppState.initial({
    @Default(AppStatus.idle) AppStatus? status,
  }) = _AppInitial;
  const factory AppState.loading({
    @Default(AppStatus.idle) AppStatus? status,
  }) = _AppLoading;
  const factory AppState.success(
    dynamic data, {
    @Default(AppStatus.idle) AppStatus? status,

    // required User? user,
  }) = _AppSucess;
  const factory AppState.failure(
    Failure failure, {
    @Default(AppStatus.idle) AppStatus? status,
  }) = _AppFailed;
}
