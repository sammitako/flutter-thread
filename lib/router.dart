import 'package:go_router/go_router.dart';
import 'package:twitter/common/main_navigation/main_navigation_screen.dart';
import 'package:twitter/features/activity/activity_screen.dart';
import 'package:twitter/features/home/home_screen.dart';
import 'package:twitter/features/profile/privacy_screen.dart';
import 'package:twitter/features/profile/profile_screen.dart';
import 'package:twitter/features/profile/settings_screen.dart';
import 'package:twitter/features/search/search_screen.dart';

final router = GoRouter(
  initialLocation: HomeScreen.routeURL,
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainNavigationScreen(child: child),
      routes: [
        GoRoute(
          path: HomeScreen.routeURL,
          name: HomeScreen.routeName,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: SearchScreen.routeURL,
          name: SearchScreen.routeName,
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: LikedScreen.routeURL,
          name: LikedScreen.routeName,
          builder: (context, state) => const LikedScreen(),
        ),
        GoRoute(
          path: ProfileScreen.routeURL,
          name: ProfileScreen.routeName,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: SettingsScreen.routeURL,
          name: SettingsScreen.routeName,
          builder: (context, state) => const SettingsScreen(),
          routes: [
            GoRoute(
              path: PrivacyScreen.routeURL,
              name: PrivacyScreen.routeName,
              builder: (context, state) => const PrivacyScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
