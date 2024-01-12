import 'article_content.dart';

class Articles2 {
  final bool hasMore;
  final int currentPage;
  final int lastPage;
  final int nextPage;
  final List<ArticleContent> list;

  Articles2({
    required this.hasMore,
    required this.currentPage,
    required this.lastPage,
    required this.nextPage,
    required this.list,
  });

  factory Articles2.fromJson(Map<String, dynamic> json) {
    List<dynamic> articlesList = json['list'] ?? [];
    List<ArticleContent> parsedList = articlesList
        .map((articleJson) => ArticleContent.fromJson(articleJson))
        .toList();

    return Articles2(
      hasMore: json['has_more'] ?? false,
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      nextPage: json['next_page'] ?? 0,
      list: parsedList,
    );
  }
}
