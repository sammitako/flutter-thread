import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class BottomAvatars extends StatelessWidget {
  final int count;
  final Faker faker;

  const BottomAvatars({
    super.key,
    required this.count,
    required this.faker,
  });

  @override
  Widget build(BuildContext context) {
    switch (count) {
      case 1:
        return CircleAvatar(
          radius: 12,
          backgroundImage: NetworkImage(
            "https://picsum.photos/seed/${faker.guid.guid()}/200",
          ),
        );
      case 2:
        return SizedBox(
          width: 36,
          height: 24,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://picsum.photos/seed/${faker.guid.guid()}/200",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://picsum.photos/seed/${faker.guid.guid()}/200",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      case 3:
        return SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: 10,
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://picsum.photos/seed/${faker.guid.guid()}/200",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://picsum.photos/seed/${faker.guid.guid()}/200",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 4,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://picsum.photos/seed/${faker.guid.guid()}/200",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
