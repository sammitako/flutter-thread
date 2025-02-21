import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/features/home/widget/bottom_avatars.dart';
import 'package:twitter/features/home/widget/ellipsis_panel.dart';

class ThreadItem extends StatelessWidget {
  final int index;
  final String username;
  final String content;
  final int replies;
  final int likes;
  final String avatarUrl;
  final List<String> imageUrls;
  final int replyAvatarCount;

  ThreadItem({
    super.key,
    required this.index,
  })  : username = Faker().person.firstName(),
        content = Faker().lorem.sentence(),
        replies = Faker().randomGenerator.integer(100),
        likes = Faker().randomGenerator.integer(1000),
        avatarUrl = "https://picsum.photos/seed/${Faker().guid.guid()}/200",
        imageUrls = List.generate(
          3,
          (index) =>
              "https://picsum.photos/seed/${Faker().guid.guid()}/355/200",
        ),
        replyAvatarCount = Faker().randomGenerator.integer(4, min: 1);

  void _onMoreTap(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const EllipsisPanel(),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (index % 2 == 0) {
      return SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, imageIndex) {
            return Container(
              margin: EdgeInsets.only(
                right: imageIndex != 2 ? 8.0 : 0,
              ),
              width: 355,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(imageUrls[imageIndex]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Text(
        content,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          fontSize: 14,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(avatarUrl),
                    ),
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade800
                        : Colors.grey.shade200,
                  ),
                ),
                BottomAvatars(
                  count: replyAvatarCount,
                  faker: Faker(),
                ),
              ],
            ),
            Gaps.h14,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          Gaps.h4,
                          const Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 14,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => _onMoreTap(context),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: FaIcon(
                            FontAwesomeIcons.ellipsis,
                            size: 14,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gaps.v6,
                  _buildContent(context),
                  Gaps.v12,
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.heart,
                        size: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      Gaps.h16,
                      FaIcon(
                        FontAwesomeIcons.comment,
                        size: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      Gaps.h16,
                      FaIcon(
                        FontAwesomeIcons.retweet,
                        size: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      Gaps.h16,
                      FaIcon(
                        FontAwesomeIcons.paperPlane,
                        size: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ],
                  ),
                  Gaps.v12,
                  Row(
                    children: [
                      Text(
                        '$replies replies',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                      Gaps.h4,
                      Text(
                        '•',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      Gaps.h4,
                      Text(
                        '$likes likes',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
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
