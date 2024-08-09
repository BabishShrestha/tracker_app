import 'package:tracker_app/core/app/infrastructure/app_state.dart';
import 'package:tracker_app/feature/auth/infrastructure/repository/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tracker_app/feature/user/repositories/user_repo.dart';

part 'app_controller.g.dart';

@riverpod
class AppNotifier extends _$AppNotifier {
  @override
  FutureOr<AppState> build() async {
    state = const AsyncData(AppState.started());
    await Future.delayed(const Duration(seconds: 2));
    return _appStarted();
  }

  Future<AppState> _appStarted() async {
    final user = await ref.read(authRepositoryProvider).isAuthenticated();
    if (user) {
      // await ref.read(userRepoProvider).subscribeForNotification();
      return const AppState.authenticated();
    } else {
      return const AppState.unAuthenticated(isSignIn: true);
    }
  }

  Future<void> updateAppState(AppState appState) async {
    state = AsyncData(appState);
  }
}
