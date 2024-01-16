import 'package:flutter/material.dart';
import 'package:lojong_app/views/home/components/article_show_all_content.dart';

import '../../../models/home/article_content.dart';
import '../../../utils/constants.dart';
import '../../../utils/share.dart';

class CardArticle extends StatelessWidget {
  final ArticleContent data;

  const CardArticle({super.key,
    required this.data
  });

  @override
  Widget build(BuildContext context) {

    void openArticleAll(BuildContext context, ArticleContent data) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ArticleShowAllContent(data: data),
      ));
    }

    String titleShare = 'Venha conferir esse novo artigo da Lojong:';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: (){
          openArticleAll(context, data);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                data.title.toUpperCase(),
                style: const TextStyle(
                  color: titleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
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
            Center(
              child: Text(
                data.text,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  shareVideo(context, titleShare,data.url, data.title);
                },
                icon: const Icon(Icons.share, color: buttonTextColor),
                label: const Text(
                  'Compartilhar',
                  style: TextStyle(
                    color: buttonTextColor,
                    fontWeight: FontWeight.bold
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
      ),
    );
  }
}