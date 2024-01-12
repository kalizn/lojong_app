class Env {
  static const Map<String, String> _keys = {
    "userToken": String.fromEnvironment("userToken"),
  };

  static String _getKey(String key) {
    final value = _keys[key] ?? '';

    if (value.isEmpty) {
      throw Exception('$key is not set in Env');
    }
    return value;
  }

  static String get userToken => _getKey("userToken");

}