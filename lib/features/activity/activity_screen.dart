import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:twitter/constants/sizes.dart';

final tabs = [
  "All",
  "Follows",
  "Replies",
  "Mentions",
  "Quotes",
  "Reposts",
  "Verified",
];

class LikedScreen extends StatefulWidget {
  static const String routeName = "activity";
  static const String routeURL = "/activity";

  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _currentIndex = 0;
  final faker = Faker();
  final List<String> names =
      List.generate(20, (index) => Faker().person.name());
  final List<String> avatars = List.generate(
      20, (index) => Faker().image.image(keywords: ['person'], random: true));
  final List<bool> _isFollowing = List.generate(20, (index) => true);

  void _onFollowTap(int index) {
    setState(() {
      _isFollowing[index] = !_isFollowing[index];
    });
  }

  Widget _buildIcon(String tab, int index) {
    // For the All tab, cycle through different activity types
    if (tab == "All") {
      final activityTypes = ["Follows", "Replies", "Mentions", "Quotes"];
      final activityType = activityTypes[index % activityTypes.length];
      return _getIconForType(activityType);
    }
    return _getIconForType(tab);
  }

  Widget _getIconForType(String type) {
    switch (type) {
      case "Follows":
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.person,
            color: Colors.white,
            size: 12,
          ),
        );
      case "Replies":
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.reply,
            color: Colors.white,
            size: 12,
          ),
        );
      case "Quotes":
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.pink,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.favorite,
            color: Colors.white,
            size: 12,
          ),
        );
      default:
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.alternate_email,
            color: Colors.white,
            size: 12,
          ),
        );
    }
  }

  String _getSubtitleForType(String tab, int index) {
    if (tab == "All") {
      final activityTypes = ["Follows", "Replies", "Mentions", "Quotes"];
      final activityType = activityTypes[index % activityTypes.length];
      switch (activityType) {
        case "Follows":
          return "Started following you";
        case "Replies":
          return "Replied to your thread";
        case "Mentions":
          return "Mentioned you";
        case "Quotes":
          return "Here's a thread you should follow if you love botany";
        default:
          return "";
      }
    }
    return tab == "Mentions"
        ? "Mentioned you"
        : "Here's a thread you should follow if you love botany";
  }

  bool _shouldShowFollowButton(String tab, int index) {
    if (tab == "All") {
      final activityTypes = ["Follows", "Replies", "Mentions", "Quotes"];
      return activityTypes[index % activityTypes.length] == "Follows";
    }
    return tab == "Follows";
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          title: Text(
            'Activity',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(52),
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  splashFactory: NoSplash.splashFactory,
                  isScrollable: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  labelPadding: const EdgeInsets.only(right: 8),
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.zero,
                  indicator: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  splashBorderRadius: BorderRadius.circular(10),
                  dividerColor: Colors.transparent,
                  labelColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                  unselectedLabelColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.size14,
                  ),
                  tabs: [
                    for (var tab in tabs)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 84,
                        height: 32,
                        decoration: BoxDecoration(
                          border: _currentIndex == tabs.indexOf(tab)
                              ? null
                              : Border.all(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.grey.shade800
                                      : Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(tab),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            for (var tab in tabs)
              ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(avatars[index]),
                            ),
                            Positioned(
                              bottom: -5,
                              right: -5,
                              child: _buildIcon(tab, index),
                            ),
                          ],
                        ),
                        title: Row(
                          children: [
                            Text(
                              names[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '4h',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          _getSubtitleForType(tab, index),
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                        trailing: _shouldShowFollowButton(tab, index)
                            ? Container(
                                height: 32,
                                constraints: const BoxConstraints(),
                                child: TextButton(
                                  onPressed: () => _onFollowTap(index),
                                  style: TextButton.styleFrom(
                                    foregroundColor: _isFollowing[index]
                                        ? Colors.grey
                                        : (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.black
                                            : Colors.white),
                                    backgroundColor: _isFollowing[index]
                                        ? Theme.of(context)
                                            .scaffoldBackgroundColor
                                        : (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.grey.shade800
                                            : Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    _isFollowing[index]
                                        ? 'Following'
                                        : 'Follow',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: _isFollowing[index]
                                          ? Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.grey.shade300
                                              : Colors.grey.shade600
                                          : (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                      if (index < 19)
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade800
                              : Colors.grey.shade200,
                          indent: 16,
                          endIndent: 16,
                        ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
