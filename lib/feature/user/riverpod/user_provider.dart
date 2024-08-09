import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/feature/user/domain/app_user.dart';

class AppUserNotifier extends StateNotifier<AppUser> {
  AppUserNotifier(
    super.state,
  );

  void update(AppUser appUser) {
    if (appUser != state) state = appUser;
  }
}

final appUserProvider = StateNotifierProvider<AppUserNotifier, AppUser>((ref) {
  return AppUserNotifier(
    const AppUser(),
  );
});
