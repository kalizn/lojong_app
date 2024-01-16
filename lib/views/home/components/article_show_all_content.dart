import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lojong_app/utils/constants.dart';

import '../../../models/home/article_content.dart';

class ArticleShowAllContent extends StatelessWidget {
  final ArticleContent data;

  const ArticleShowAllContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    print(data.authorImage);
    String colorToHex(Color color) {
      return '#${color.value.toRadixString(16).padLeft(8, '0')}';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      data.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kIconsShare,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 8,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    // Ajuste a altura conforme necessário
                    child: Html(
                      data:
                          '<div style="color: ${colorToHex(kIconsShare)};">${data.fullText}</div>',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    color: Colors.grey[50],
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: data.authorImage.isNotEmpty
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              data.authorImage,
                              height: 70.0,
                              width: 70.0,
                              fit: BoxFit.cover,
                            ),
                          )
                              : const Icon(
                            Icons.person,
                            size: 70.0,
                            color: kIconsShare,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              Text(
                                data.authorName,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: kIconsShare,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                data.authorDescription,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: kIconsShare,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'COMPARTILHAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
