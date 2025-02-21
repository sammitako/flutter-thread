class Post {
  final String username;
  final bool isVerified;
  final String timeAgo;
  final String content;
  final int likes;
  final int replies;
  final String userAvatar;
  final List<String> replyAvatars;
  final List<String>? images;
  final bool hasCreatorPlus;

  Post({
    required this.username,
    required this.isVerified,
    required this.timeAgo,
    required this.content,
    required this.likes,
    required this.replies,
    required this.userAvatar,
    required this.replyAvatars,
    this.images,
    this.hasCreatorPlus = false,
  });
}
