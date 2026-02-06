import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'presentation/pages/splash_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/history_page.dart';
import 'presentation/pages/settings_page.dart';
import 'presentation/providers/app_providers.dart';

  runApp(const ProviderScope(child: MedicineAnalyzerApp()));
}

class MedicineAnalyzerApp extends ConsumerWidget {
  const MedicineAnalyzerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      title: AppStrings.appName,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/history': (context) => const HistoryPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
