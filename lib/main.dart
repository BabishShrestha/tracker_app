import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/core/theme/application/theme_provider.dart';
import 'package:tracker_app/core/app_setup/hive/hive_setup.dart';
import 'package:tracker_app/core/routes/routes.dart';
import 'package:tracker_app/core/theme/app_theme.dart';
import 'package:tracker_app/my_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    HiveSetup.initHive(),

    ///create an .env file and add your IP  as [API_IP] to run the api locally
    // dotenv.load(fileName: '.env'),
  ]);

  runApp(
    ProviderScope(
      observers: [
        MyObserver(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Tracker App',
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: themeMode.value,
      routerConfig: routes,
    );
  }
}
