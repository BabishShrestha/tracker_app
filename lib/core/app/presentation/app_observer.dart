import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/core/app/application/app_controller.dart';
import 'package:tracker_app/features/auth/presentation/signin_screen.dart';
import 'package:tracker_app/features/auth/presentation/signup_screen.dart';
import 'package:tracker_app/features/home/presentation/home_screen.dart';

class AppObserver extends ConsumerStatefulWidget {
  const AppObserver({super.key});

  @override
  ConsumerState<AppObserver> createState() => _AppObserverState();
}

class _AppObserverState extends ConsumerState<AppObserver> {
  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appNotifierProvider).asData?.value;

    return Scaffold(
      body: Center(
        child: appState?.map(
          started: (_) => const CircularProgressIndicator(),
          authenticated: (_) => const HomeScreen(),
          unAuthenticated: (value) {
            if (value.isSignIn) return const SignInScreen();
            return const SignUpScreen();
          },
        ),
      ),
    );
  }
}
