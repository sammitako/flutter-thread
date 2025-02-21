import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/features/profile/privacy_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = "settings";
  static const String routeURL = "/settings";

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isLoading = false;

  void _onLogOutTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Platform.isIOS
          ? CupertinoAlertDialog(
              title: const Text('Log out?'),
              content: const Text('You can always log back in'),
              actions: [
                CupertinoDialogAction(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text('Log out'),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _isLoading = true;
                    });
                    Future.delayed(
                      const Duration(seconds: 2),
                      () {
                        if (mounted) {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                    );
                  },
                ),
              ],
            )
          : AlertDialog.adaptive(
              title: const Text('Log out?'),
              content: const Text('You can always log back in'),
              actions: [
                TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('Log out'),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _isLoading = true;
                    });
                    Future.delayed(
                      const Duration(seconds: 2),
                      () {
                        if (mounted) {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                    );
                  },
                ),
              ],
            ),
    );
  }

  void _onPrivacyTap(BuildContext context) {
    context.pushNamed(PrivacyScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: () => context.pop(),
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
          'Settings',
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
          ListTile(
            leading: Icon(
              Icons.person_add_outlined,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Follow and invite friends',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_none,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.lock_outline,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Privacy',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            onTap: () => _onPrivacyTap(context),
          ),
          ListTile(
            leading: Icon(
              Icons.person_outline,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Account',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.help_outline,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Help',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              'About',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            onTap: () {},
          ),
          Divider(
            height: 1,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),
          ListTile(
            title: const Text(
              'Log out',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
              ),
            ),
            trailing: _isLoading
                ? CupertinoActivityIndicator(
                    color: isDark ? Colors.white : Colors.black,
                  )
                : null,
            onTap: () => _onLogOutTap(context),
          ),
        ],
      ),
    );
  }
}
