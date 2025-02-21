import 'package:flutter/material.dart';
import 'package:twitter/constants/sizes.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      clipBehavior: Clip.hardEdge,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Sizes.size20),
        ),
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            const SizedBox(height: Sizes.size20),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),
            PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Container(
                color: backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Report',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Divider(
                      height: 1,
                      color:
                          isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size16, vertical: Sizes.size16),
                children: [
                  Text(
                    'Why are you reporting this thread?',
                    style: TextStyle(
                      fontSize: Sizes.size18,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
                    child: Text(
                      'Your report is anonymous, except if you\'re reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don\'t wait.',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        color: isDark
                            ? Colors.grey.shade300
                            : Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                  ),
                  ...ListTile.divideTiles(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                    context: context,
                    tiles: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'I just don\'t like it',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: isDark ? Colors.grey.shade300 : Colors.grey,
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'It\'s unlawful content under NetzDG',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: isDark ? Colors.grey.shade300 : Colors.grey,
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'It\'s spam',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: isDark ? Colors.grey.shade300 : Colors.grey,
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Hate speech or symbols',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: isDark ? Colors.grey.shade300 : Colors.grey,
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Nudity or sexual activity',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: isDark ? Colors.grey.shade300 : Colors.grey,
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'False information',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: isDark ? Colors.grey.shade300 : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
