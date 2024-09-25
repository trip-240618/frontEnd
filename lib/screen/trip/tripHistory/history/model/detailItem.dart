class Comment {
  String username;
  String content;
  DateTime timestamp;

  Comment({
    required this.username,
    required this.content,
    required this.timestamp,
  });
}

class DetailItem {
  String imageUrl;
  List<Comment> comments;

  DetailItem({
    required this.imageUrl,
    required this.comments,
  });
}
