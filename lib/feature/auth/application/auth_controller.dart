import 'package:flutter/material.dart';
import 'package:tracker_app/core/app/application/app_controller.dart';
import 'package:tracker_app/core/app/infrastructure/app_state.dart';
import 'package:tracker_app/feature/auth/infrastructure/repository/auth_repository.dart';
import 'package:tracker_app/feature/auth/infrastructure/repository/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tracker_app/feature/user/domain/app_user.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late IAuthRepository authRepository;
  @override
  FutureOr<void> build() {
    authRepository = ref.read(authRepositoryProvider);
  }

  Future<void> signup({
    required AppUser appUser,
  }) async {
    state = const AsyncValue.loading();
    final response = await authRepository.signup(
      appUser: appUser,
    );
    response.fold((failure) {
      state = AsyncValue.error(
        failure.reason,
        StackTrace.current,
      );
    }, (success) {
      //navigate to homescreen after register success
      ref.read(appNotifierProvider.notifier).updateAppState(
            const AppState.authenticated(),
          );
      state = AsyncValue.data(success);
    });
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final response = await authRepository.login(
      email: email,
      password: password,
    );

    response.fold((failure) {
      state = AsyncValue.error(
        failure.reason,
        StackTrace.current,
      );
    }, (success) async {
      // await authRepository.saveToken(token: success);
      ref
          .read(appNotifierProvider.notifier)
          .updateAppState(const AppState.authenticated());
      state = AsyncValue.data(success);
    });
  }

  void signOut(BuildContext context) {
    // _ref.read(isAuthenticated.notifier).state = false;
    authRepository.signOut();
    ref
        .read(appNotifierProvider.notifier)
        .updateAppState(const AppState.unAuthenticated(isSignIn: true));
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(
    //       builder: (context) => const LoginPage(),
    //     ),
    //     (route) => false);
    state = const AsyncValue.data(null);
  }
}
