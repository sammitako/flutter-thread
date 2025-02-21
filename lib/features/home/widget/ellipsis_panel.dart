import 'package:flutter/material.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/home/report_screen.dart';

class EllipsisPanel extends StatelessWidget {
  const EllipsisPanel({super.key});

  void _onReportTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ReportScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
      height: size.height * 0.4,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Sizes.size24),
        ),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            const SizedBox(height: Sizes.size24),
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
            Padding(
                padding: const EdgeInsets.symmetric(vertical: Sizes.size24),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Sizes.size20),
                    ),
                  ),
                  child: Column(children: [
                    ListTile(
                      title: Text(
                        'Unfollow',
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color:
                          isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    ),
                    ListTile(
                      title: Text(
                        'Mute',
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ]),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: Sizes.size12),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Sizes.size18),
                    ),
                  ),
                  child: Column(children: [
                    ListTile(
                      title: Text(
                        'Hide',
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color:
                          isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    ),
                    ListTile(
                      onTap: () => _onReportTap(context),
                      title: const Text(
                        'Report',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
                )),
          ],
        ),
      ),
    );
  }
}
