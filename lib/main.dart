import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/router.dart';
import 'package:twitter/view_models/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // Provider Implementation
  /*
  final themeViewModel = ThemeViewModel();
  await themeViewModel.initializeTheme();
  runApp(
    ChangeNotifierProvider(
      create: (_) => themeViewModel,
      child: const MyApp(),
    ),
  );
  */

  // Riverpod Implementation
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Provider Implementation
/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeViewModel>().isDarkMode;
    return MaterialApp.router(
    
    );
  }
}
*/

// Riverpod Implementation
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    return MaterialApp.router(
      routerConfig: router,
      title: 'Twitter',
      theme: ThemeData(
        primaryColor: const Color(0xFF4A98E9),
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        tabBarTheme: const TabBarTheme(
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
        ),
        textTheme: Typography.blackMountainView,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primaryColor: const Color(0xFF4A98E9),
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        tabBarTheme: const TabBarTheme(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.black,
        ),
        textTheme: Typography.whiteMountainView,
        brightness: Brightness.dark,
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }
}

// Helper function to check dark mode
bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;
