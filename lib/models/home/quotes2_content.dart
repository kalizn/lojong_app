class Quotes2Content {
  final int id;
  final String text;
  final String author;
  final int order;

  const Quotes2Content({
    required this.id,
    required this.text,
    required this.author,
    required this.order,
  });

  factory Quotes2Content.fromJson(Map<String, dynamic> json) {
    return Quotes2Content(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      author: json['author'] ?? '',
      order: json['order'] ?? 0,
    );
  }
}
