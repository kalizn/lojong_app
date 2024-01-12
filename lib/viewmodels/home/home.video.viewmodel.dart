import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../models/home/video.dart';
import '../../services/connection.dart';

class HomeVideoViewModel with ChangeNotifier {
  late Video video;
  final Connection connection;

  HomeVideoViewModel({required this.connection});

  Future<Response> loadData(String endpoint, Map<String, dynamic> parameters) async {
    try {
      print('Chamando fetchData...');
      Response response = await connection.fetchData(endpoint, parameters);

      // Agora você pode usar a resposta conforme necessário
      print('Resposta: ${response.data}');

      return response;
    } catch (e, stackTrace) {
      print('Erro ao carregar os dados: $e');
      print('StackTrace: $stackTrace');

      // Criar um Response com status de erro
      return Response(
        statusCode: 500,
        requestOptions: RequestOptions(path: endpoint),
      );
    }
  }
}
