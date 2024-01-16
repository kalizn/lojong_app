class Env {
  static const Map<String, String> _keys = {
    "userToken": String.fromEnvironment("userToken"),
    "urlBase": String.fromEnvironment("urlBase"),
    "video": String.fromEnvironment("video"),
    "listArticles": String.fromEnvironment("listArticles"),
    "contentArticles": String.fromEnvironment("contentArticles"),
    "quotes": String.fromEnvironment("quotes"),
  };

  static String _getKey(String key) {
    final value = _keys[key] ?? '';

    if (value.isEmpty) {
      throw Exception('$key is not set in Env');
    }
    return value;
  }

  static String get userToken => _getKey("userToken");
  static String get urlBase => _getKey("urlBase");
  static String get video => _getKey("video");
  static String get listArticles => _getKey("listArticles");
  static String get contentArticles => _getKey("contentArticles");
  static String get quotes => _getKey("quotes");
}