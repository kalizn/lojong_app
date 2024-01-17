import 'package:flutter/material.dart';

import '../../../models/home/video.dart';
import '../../../utils/constants.dart';
import '../../../utils/share.dart';
import 'web_view_page.dart';

class CardVideo extends StatelessWidget {
  final Video data;

  const CardVideo({super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    String titleShare = 'Confira esse vídeo incrível da Lojong:';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              data.name.toUpperCase(),
              style: const TextStyle(
                color: Color.fromRGBO(139, 143, 153, 1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.black,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    data.imageUrl, // You can use a thumbnail URL if available
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.play_circle_fill,
                  size: 50.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  _openWebView(context, data.url, data.name);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              data.description,
              style: const TextStyle(
                color: kTextDescription,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                shareVideo(context, titleShare,data.url, data.name);
              },
              icon: const Icon(Icons.share, color: kIconsShare),
              label: const Text(
                'Compartilhar',
                style: TextStyle(
                  color: kIconsShare,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kButtonShare,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }

  void _openWebView(BuildContext context, String url, String title) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => WebViewPage(url: url, title:  title,),
    ));
  }
}


