import 'quotes2_content.dart';

class Quotes2 {
  final bool hasMore;
  final int currentPage;
  final int lastPage;
  final int nextPage;
  final List<Quotes2Content> list;

  Quotes2({
    required this.hasMore,
    required this.currentPage,
    required this.lastPage,
    required this.nextPage,
    required this.list,
  });

  factory Quotes2.fromJson(Map<String, dynamic> json) {
    List<dynamic> quotesList = json['list'] ?? [];
    List<Quotes2Content> parsedList = quotesList
        .map((quoteJson) => Quotes2Content.fromJson(quoteJson))
        .toList();

    return Quotes2(
      hasMore: json['has_more'] ?? false,
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      nextPage: json['next_page'] ?? 0,
      list: parsedList,
    );
  }
}
