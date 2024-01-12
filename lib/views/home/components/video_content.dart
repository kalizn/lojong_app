import 'package:flutter/material.dart';
import '../../../viewmodels/home/home.video.viewmodel.dart';

class VideoContent extends StatelessWidget {
  final HomeVideoViewModel viewModel;

  const VideoContent({required this.viewModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final params = {"page": 1};

    return FutureBuilder(
      future: viewModel.loadData('videos', params),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text('Erro: ${snapshot.error}');
        } else {
          return Center(child: Text('Dados do Vídeo: ${snapshot.data}'));
        }
      },
    );
  }
}
