import 'package:flutter/material.dart';

import '../../models/home/article_content.dart';
import '../../models/home/articles2.dart';
import '../../models/home/quotes2_content.dart';
import '../../models/home/video.dart';
import '../../models/services_connection_env/services_connection_env.dart';
import '../../services/connection.dart';
import '../../utils/print_debug.dart';

class HomeViewModel extends ChangeNotifier {
  final Connection connection = Connection();
  List<ArticleContent> articlesContent = [];
  List<ListItem> listItem = [];
  List<Quotes2Content> quotes = [];
  List<Video> videos = [];

  bool isLoading = false;
  bool isError = false;

  @override
  void notifyListeners() {
    notifyListeners();
  }

  HomeViewModel({int? articleId}) {
    loadArticlesList();
    loadVideos();
    loadQuotes();
  }

  Future<void> loadArticlesList() async {
    try {
      isLoading = true;
      notifyListeners();

      bool isInternetAvailable = await connection.isInternetWorking();

      print(isInternetAvailable);
      if (isInternetAvailable) {
        final response = await connection.fetchDataMap(Env.listArticles, params: {});
        if (response['list'] != null) {
          List<ArticleContent> newArticles = (response['list'] as List)
              .map((item) => ArticleContent.fromJson(item))
              .toList();

          for (var articlec in newArticles) {
            if (articlec.fullText.isEmpty || articlec.authorImage.isEmpty || articlec.authorDescription.isEmpty) {
              final additionalData = await connection.fetchDataMap(Env.contentArticles, params: {"articleid": articlec.id});

              articlec.fullText = additionalData['full_text'] ?? articlec.fullText;
              articlec.authorImage = additionalData['author_image'] ?? articlec.authorImage;
              articlec.authorDescription = additionalData['author_description'] ?? articlec.authorDescription;
            }

            // Download cached image
            await connection.downloadCachedImage(articlec.imageUrl);
          }

          // Add the modified articles to the list
          articlesContent.addAll(newArticles);
        }
      } else {
        print('ficou falso');
        final List<ArticleContent> cachedArticles = await connection.getCachedArticleContent();
        if (cachedArticles.isNotEmpty) {
          print('está cheio');
          articlesContent.addAll(cachedArticles);
        } else {
          print('deu erro');
          isError = true;
          notifyListeners();
        }
      }

      isError = false;
      isLoading = false;
      notifyListeners();
    } catch (e) {

      isError = true;
      notifyListeners();
      printDebug('Error loading articles: $e');
    } finally {
      isLoading = false;
    }
  }


  Future<void> loadListItems() async {
    try {
      isLoading = true;
      notifyListeners();

      bool isInternetAvailable = await connection.isInternetWorking();

      if (isInternetAvailable) {
        final response = await connection.fetchDataMap(Env.listArticles, params: {});
        if (response['list'] != null) {
          listItem.addAll((response['list'] as List)
              .map((item) => ListItem.fromJson(item))
              .toList());
        }

      } else {
        final List<ListItem> cachedListItems = await connection.getCachedListItem();

        if (cachedListItems.isNotEmpty) {
          listItem.addAll(cachedListItems);
        } else {
          isError = true;
          notifyListeners();
        }
      }

      isError = false;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isError = true;
      notifyListeners();
      printDebug('Error loading list items: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadQuotes() async {
    try {
      isLoading = true;
      notifyListeners();

      bool isInternetAvailable = await connection.isInternetWorking();

      if (isInternetAvailable) {
        final response = await connection.fetchDataMap(Env.quotes, params: {});
        if (response['list'] != null) {
          quotes.addAll((response['list'] as List)
              .map((item) => Quotes2Content.fromJson(item))
              .toList());
        }
      } else {
        final List<Quotes2Content> cachedQuotes = await connection.getCachedQuotes2();
        if (cachedQuotes.isNotEmpty) {
          quotes.addAll(cachedQuotes);

        } else {
          isError = true;
          notifyListeners();
        }
      }

      isError = false;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isError = true;
      notifyListeners();
      printDebug('Error loading quotes: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadVideos() async {
    try {
      isLoading = true;
      notifyListeners();

      bool isInternetAvailable = await connection.isInternetWorking();

      if (isInternetAvailable) {
        final response = await connection.fetchData(Env.video, params: {});
        if (response.statusCode == 200) {
          final List<dynamic> responseData = response.data;
          final List<Video> listVideo = responseData
              .map((item) => Video.fromJson(item))
              .toList();


          for (var video in listVideo) {
            await connection.downloadCachedImage(video.imageUrl);
          }

          videos.addAll(listVideo);
        }
      } else {
        final List<Video> cachedVideos = await connection.getCachedVideo();
        if (cachedVideos.isNotEmpty) {
          videos.addAll(cachedVideos);

        } else {
          isError = true;
          notifyListeners();
        }
      }

      isError = false;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isError = true;
      notifyListeners();
      printDebug('Error loading videos: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
