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

class Tag {
  int color;
  String tagName;
  Tag({
    required this.color,
    required this.tagName,
  });
}

class DetailItem {
  String imageUrl;
  List<Comment> comments;
  List<Tag> tagData;
  DetailItem({
    required this.imageUrl,
    required this.comments,
    required this.tagData,
  });
}
