import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lojong_app/utils/print_debug.dart';

import '../../../models/home/article_content.dart';
import '../../../utils/constants.dart';
import '../../../utils/share.dart';

class ArticleShowAllContent extends StatelessWidget {
  static String routeName = '/articlesAllContent';
  final ArticleContent? data;

  const ArticleShowAllContent({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    printDebug(data!.authorImage);
    String colorToHex(Color color) {
      return '#${color.value.toRadixString(16).padLeft(8, '0')}';
    }

    String titleShare = 'Venha conferir esse novo artigo da Lojong:';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kSecondaryColor,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 40),
                child: Center(
                  child: Text(
                    '',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
                      data!.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data!.title,
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
                    child: Html(
                      data:
                          '<div style="color: ${colorToHex(kIconsShare)};">${data!.fullText}</div>',
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
                          child: data!.authorImage.isNotEmpty
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              data!.authorImage,
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
                                data!.authorName,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: kIconsShare,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                data!.authorDescription,
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
                    onPressed: () {
                      shareVideo(context, titleShare, data!.url, data!.title);
                    },
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
