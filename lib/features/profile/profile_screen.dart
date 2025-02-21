import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/features/profile/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "profile";
  static const String routeURL = "/profile";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final faker = Faker();

  // Store initial profile data
  late String profileAvatar;
  late List<String> followerAvatars;
  late int followerCount;

  @override
  void initState() {
    super.initState();
    profileAvatar = faker.image.image(keywords: ['plant'], random: true);
    followerAvatars = List.generate(
      2,
      (index) => faker.image.image(keywords: ['person'], random: true),
    );
    followerCount = 2;
  }

  void _onSettingsTap(BuildContext context) {
    context.pushNamed(SettingsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 260,
              backgroundColor: isDark ? Colors.black : Colors.white,
              surfaceTintColor: isDark ? Colors.black : Colors.white,
              pinned: true,
              elevation: 0,
              stretch: true,
              leading: Icon(Icons.language,
                  color: isDark ? Colors.white : Colors.black),
              actions: [
                Icon(FontAwesomeIcons.instagram,
                    color: isDark ? Colors.white : Colors.black),
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(Icons.menu,
                      color: isDark ? Colors.white : Colors.black),
                  onPressed: () => _onSettingsTap(context),
                ),
                const SizedBox(width: 16),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    const SizedBox(height: 120),
                    ListTile(
                      title: Text(
                        'Jane',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            'jane_mobbin',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.grey.shade300
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.grey.shade800
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'threads.net',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(profileAvatar),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Plant enthusiast!',
                            style: TextStyle(
                              fontSize: 16,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              SizedBox(
                                width: 60,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundImage: NetworkImage(
                                        followerAvatars[0],
                                      ),
                                    ),
                                    Positioned(
                                      left: 20,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(
                                          followerAvatars[1],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '2 followers',
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.grey.shade300
                                      : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        isDark ? Colors.black : Colors.white,
                                    foregroundColor:
                                        isDark ? Colors.white : Colors.black,
                                    side: BorderSide(
                                      color: isDark
                                          ? Colors.grey.shade800
                                          : Colors.black12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Edit profile'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        isDark ? Colors.black : Colors.white,
                                    foregroundColor:
                                        isDark ? Colors.white : Colors.black,
                                    side: BorderSide(
                                      color: isDark
                                          ? Colors.grey.shade800
                                          : Colors.black12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Share profile'),
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
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  labelColor: isDark ? Colors.white : Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: isDark ? Colors.white : Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.zero,
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(text: 'Threads'),
                    Tab(text: 'Replies'),
                  ],
                ),
                isDark,
              ),
              pinned: true,
            ),
          ],
          body: TabBarView(
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 20,
                itemBuilder: (context, index) {
                  final isReposted = index % 3 == 0;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              minVerticalPadding: 0,
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(profileAvatar),
                              ),
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'jane_mobbin',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        if (isReposted)
                                          Text(
                                            'Tea. Spillage.',
                                            style: TextStyle(
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 14,
                                            ),
                                          )
                                        else
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Give ',
                                                  style: TextStyle(
                                                    color: isDark
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '@john_mobbin',
                                                  style: TextStyle(
                                                    color: Colors.blue[600],
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      ' a follow if you want to see more travel content!',
                                                  style: TextStyle(
                                                    color: isDark
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '5h',
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.grey.shade300
                                              : Colors.grey[500],
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Icon(
                                        Icons.more_horiz,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (isReposted)
                              Container(
                                margin: const EdgeInsets.only(left: 56),
                                padding: const EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isDark
                                        ? Colors.grey.shade800
                                        : Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 8,
                                          backgroundImage: NetworkImage(
                                            "https://avatars.githubusercontent.com/u/87654321",
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'iwetmyyplants',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: const [
                                            FaIcon(
                                              FontAwesomeIcons.certificate,
                                              color: Colors.blue,
                                              size: 12,
                                            ),
                                            FaIcon(
                                              FontAwesomeIcons.check,
                                              color: Colors.white,
                                              size: 6,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "I'm just going to say what we are all thinking and knowing is about to go downity down: There is about to be some piping hot tea spillage on here daily that people will be...",
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.only(left: 56),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    size: 20,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(
                                    Icons.chat_bubble_outline,
                                    size: 20,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(
                                    Icons.repeat,
                                    size: 20,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(
                                    Icons.send_outlined,
                                    size: 20,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                      ),
                    ],
                  );
                },
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/12345678",
                                  ),
                                ),
                                Container(
                                  width: 2,
                                  height: 200,
                                  color: isDark
                                      ? Colors.grey.shade800
                                      : Colors.grey.withOpacity(0.3),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(profileAvatar),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'john_mobbin',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '5h',
                                                  style: TextStyle(
                                                    color: isDark
                                                        ? Colors.grey.shade300
                                                        : Colors.grey[500],
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Icon(
                                                  Icons.more_horiz,
                                                  color: isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Always a dream to see the Medina in Morocco!',
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 12),
                                          padding: const EdgeInsets.all(13),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: isDark
                                                  ? Colors.grey.shade800
                                                  : Colors.grey
                                                      .withOpacity(0.3),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 8,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      "https://avatars.githubusercontent.com/u/87654321",
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'earthpix',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                      color: isDark
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: const [
                                                      FaIcon(
                                                        FontAwesomeIcons
                                                            .certificate,
                                                        color: Colors.blue,
                                                        size: 12,
                                                      ),
                                                      FaIcon(
                                                        FontAwesomeIcons.check,
                                                        color: Colors.white,
                                                        size: 6,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                "What is one place you're absolutely traveling to by next year?",
                                                style: TextStyle(
                                                  color: isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Text(
                                                '256 replies',
                                                style: TextStyle(
                                                  color: isDark
                                                      ? Colors.grey.shade300
                                                      : Colors.grey[600],
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.favorite_border,
                                              size: 20,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            const SizedBox(width: 16),
                                            Icon(
                                              Icons.chat_bubble_outline,
                                              size: 20,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            const SizedBox(width: 16),
                                            Icon(
                                              Icons.repeat,
                                              size: 20,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            const SizedBox(width: 16),
                                            Icon(
                                              Icons.send_outlined,
                                              size: 20,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'jane_mobbin',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '5h',
                                                  style: TextStyle(
                                                    color: isDark
                                                        ? Colors.grey.shade300
                                                        : Colors.grey[500],
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Icon(
                                                  Icons.more_horiz,
                                                  color: isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'See you there!',
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.favorite_border,
                                              size: 20,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            const SizedBox(width: 16),
                                            Icon(
                                              Icons.chat_bubble_outline,
                                              size: 20,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            const SizedBox(width: 16),
                                            Icon(
                                              Icons.repeat,
                                              size: 20,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            const SizedBox(width: 16),
                                            Icon(
                                              Icons.send_outlined,
                                              size: 20,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar, this._isDark);

  final TabBar _tabBar;
  final bool _isDark;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: _isDark ? Colors.black : Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
