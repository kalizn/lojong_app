import 'package:dio/dio.dart';

import '../models/services_connection_env/services_connection_env.dart';

class Connection {
  static const String _baseUrl = 'https://applojong.com/api';
  static String userToken = Env.userToken;

  final Dio _dio = Dio();

  static Map<String, String> getDefaultHeaders() {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $userToken",
    };
  }

  Future<Response> fetchData(
      String endpoint, Map<String, dynamic> parameters) async {
    try {

      final response = await _dio.get<List>(
        '$_baseUrl/$endpoint',
        queryParameters: parameters,
        options: Options(
          headers: getDefaultHeaders(),
        ),
      );
      print(response.data);

      // Aqui você pode obter a URL completa da requisição
      String requestUrl = response.requestOptions.uri.toString();
      print('URL da requisição: $requestUrl');

      return response;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
