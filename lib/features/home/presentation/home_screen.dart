import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:tracker_app/core/app/application/app_controller.dart';
import 'package:tracker_app/core/app/infrastructure/app_state.dart';
import 'package:tracker_app/core/app_setup/connectivity/connectivity_service.dart';
import 'package:tracker_app/core/app_setup/hive/hive_box.dart';
import 'package:tracker_app/core/theme/application/theme_provider.dart'
    as theme;
import 'package:tracker_app/core/widgets/custom_button.dart';
import 'package:tracker_app/features/auth/application/auth_controller.dart';
import 'package:tracker_app/features/maps/data/location_provider.dart';
import 'package:tracker_app/features/maps/presentation/widgets/map_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    ref.read(connectivityServiceProvider).startMonitoring();

    super.initState();
  }

  @override
  void deactivate() {
    ref.read(connectivityServiceProvider).stopMonitoring();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        toolbarHeight: 80,
        actions: [
          const _ThemeSwitchWidget(),
          SizedBox(
            child: CustomButton(
              name: 'Logout',
              onPressed: () async {
                await ref.read(locationProvider).listenLocation(false);
                for (final box in HiveBox.hiveBoxes) {
                  await Hive.deleteBoxFromDisk(box);
                }
                await Hive.deleteFromDisk();
                if (mounted) {
                  ref.read(authNotifierProvider.notifier).signOut(context);
                }
                ref.read(appNotifierProvider.notifier).updateAppState(
                      const AppState.unAuthenticated(isSignIn: true),
                    );
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Tracker app',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: const MapsView()),
          ],
        ),
      ),
    );
  }
}

class _ThemeSwitchWidget extends ConsumerWidget {
  const _ThemeSwitchWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(theme.themeProvider).asData?.value;
    return Row(
      children: [
        const Icon(Icons.light_mode_outlined),
        CupertinoSwitch(
          value: themeMode == ThemeMode.dark,
          onChanged: (value) {
            ref.read(theme.themeProvider.notifier).changeTheme(isDark: value);
          },
        ),
        const Icon(Icons.dark_mode_outlined),
      ],
    );
  }
}
