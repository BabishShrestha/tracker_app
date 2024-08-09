import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/core/app/infrastructure/app_state.dart';
import 'package:tracker_app/core/app/application/app_controller.dart';

class ErrorInterceptors extends InterceptorsWrapper {
  Ref ref;
  ErrorInterceptors({
    required this.ref,
  });
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // ref
      //     .read(appNotifierProvider.notifier)
      //     .updateAppState(const AppState.unAuthenticated(isSignIn: true));
    }
    super.onError(err, handler);
  }
}
