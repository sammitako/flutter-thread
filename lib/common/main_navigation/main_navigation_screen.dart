import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/common/main_navigation/widgets/nav_item.dart';
import 'package:twitter/features/activity/activity_screen.dart';
import 'package:twitter/features/home/home_screen.dart';
import 'package:twitter/features/profile/profile_screen.dart';
import 'package:twitter/features/search/search_screen.dart';
import 'package:twitter/features/thread/new_thread_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final Widget child;

  const MainNavigationScreen({
    super.key,
    required this.child,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    HomeScreen.routeURL,
    SearchScreen.routeURL,
    "write",
    LikedScreen.routeURL,
    ProfileScreen.routeURL,
  ];

  int get _selectedIndex {
    final String location = GoRouterState.of(context).uri.path;
    // For settings routes, we want to keep profile selected
    if (location.startsWith('/settings')) {
      return _tabs.indexOf(ProfileScreen.routeURL);
    }
    // Handle nested routes by getting the first part of the path
    final String baseLocation = location.split('/')[1];
    final int index = _tabs.indexWhere((tab) {
      if (tab == "write") return false;
      return tab.replaceAll('/', '') == baseLocation;
    });
    return index == -1 ? 0 : index;
  }

  void _onTap(int index) {
    if (index == 2) {
      _onPostTap();
      return;
    }
    context.go(_tabs[index]);
  }

  void _onPostTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) => const NewThreadScreen(),
    ).whenComplete(() {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: widget.child,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).bottomAppBarTheme.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavItem(
              isSelected: _selectedIndex == 0,
              onTap: () => _onTap(0),
              icon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              selectedIndex: _selectedIndex,
              isDark: isDark,
            ),
            NavItem(
              isSelected: _selectedIndex == 1,
              onTap: () => _onTap(1),
              icon: FontAwesomeIcons.magnifyingGlass,
              selectedIcon: FontAwesomeIcons.magnifyingGlass,
              selectedIndex: _selectedIndex,
              isDark: isDark,
            ),
            NavItem(
              isSelected: false,
              onTap: () => _onTap(2),
              icon: FontAwesomeIcons.penToSquare,
              selectedIcon: FontAwesomeIcons.solidPenToSquare,
              selectedIndex: _selectedIndex,
              isDark: isDark,
            ),
            NavItem(
              isSelected: _selectedIndex == 3,
              onTap: () => _onTap(3),
              icon: FontAwesomeIcons.heart,
              selectedIcon: FontAwesomeIcons.solidHeart,
              selectedIndex: _selectedIndex,
              isDark: isDark,
            ),
            NavItem(
              isSelected: _selectedIndex == 4,
              onTap: () => _onTap(4),
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              selectedIndex: _selectedIndex,
              isDark: isDark,
            )
          ],
        ),
      ),
    );
  }
}
