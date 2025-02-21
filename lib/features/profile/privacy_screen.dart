import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/view_models/theme_notifier.dart';

// Provider Implementation
/*
class PrivacyScreen extends StatefulWidget {
  static const String routeName = "privacy";
  static const String routeURL = "privacy";

  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _isPrivate = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeViewModel = context.watch<ThemeViewModel>();
    
    SwitchListTile.adaptive(
      value: themeViewModel.isDarkMode,
      onChanged: (value) => themeViewModel.toggleTheme(),
      secondary: Icon(
        themeViewModel.isDarkMode ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
        color: isDark ? Colors.white : Colors.black,
      ),
    ),
  }
}
*/

// Riverpod Implementation
class PrivacyScreen extends ConsumerStatefulWidget {
  static const String routeName = "privacy";
  static const String routeURL = "privacy";

  const PrivacyScreen({super.key});

  @override
  ConsumerState<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends ConsumerState<PrivacyScreen> {
  bool _isPrivate = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(
                  Icons.chevron_left,
                  color: isDark ? Colors.white : Colors.black,
                  size: 32,
                ),
                Text(
                  "Back",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Privacy',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: isDarkMode,
            onChanged: (value) =>
                ref.read(themeProvider.notifier).toggleTheme(),
            secondary: Icon(
              isDarkMode ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Dark mode',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          // Divider(
          //   height: 1,
          //   color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          // ),
          SwitchListTile.adaptive(
            activeColor: isDark ? Colors.white : Colors.black,
            value: _isPrivate,
            onChanged: (value) => setState(() {
              _isPrivate = value;
            }),
            title: Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  color: isDark ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 16),
                Text(
                  'Private profile',
                  style: TextStyle(
                    fontSize: 18,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.alternate_email,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Mentions',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Everyone',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.bellSlash,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Muted',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.grey.shade500,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.eyeSlash,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Hidden Words',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.grey.shade500,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.people_outline,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Profiles you follow',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.grey.shade500,
            ),
            onTap: () {},
          ),
          Divider(
            height: 1,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Other privacy settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Icon(
                  Icons.open_in_new,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.circleXmark,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Blocked profiles',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: Icon(
              Icons.open_in_new,
              color: Colors.grey.shade500,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.heartCrack,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Hide likes',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            trailing: Icon(
              Icons.open_in_new,
              color: Colors.grey.shade500,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
