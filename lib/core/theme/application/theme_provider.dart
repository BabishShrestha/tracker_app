import 'package:flutter/material.dart';
import 'package:tracker_app/core/theme/infrastructure/theme_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class Theme extends _$Theme {
  @override
  FutureOr<ThemeMode> build() async {
    state = const AsyncData(ThemeMode.light);
    final theme = await ref.read(iThemeRepositoryProvider).getCurrentTheme();
    return theme ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> changeTheme({
    required bool isDark,
  }) async {
    await ref
        .read(iThemeRepositoryProvider)
        .cacheCurrentTheme(isDarkMode: isDark);
    state = AsyncValue.data(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
