import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../models/home/article_content.dart';
import '../models/home/articles2.dart';
import '../models/home/quotes2.dart';
import '../models/home/quotes2_content.dart';
import '../models/home/video.dart';
import '../models/services_connection_env/services_connection_env.dart';

class Connection {
  static final String _urlBase = Env.urlBase;
  static String userToken = Env.userToken;

  late Dio _dio;
  late CacheManager _cacheManager;

  Connection() {
    _dio = Dio();
    _dio.options.baseUrl = _urlBase;
    _dio.options.headers = getDefaultHeaders();

    _cacheManager = CacheManager(
      Config(
        'api_cache',
        stalePeriod: const Duration(days: 7),
        maxNrOfCacheObjects: 100,
      ),
    );
  }

  Dio get dioInstance => _dio;

  Map<String, String> getDefaultHeaders() {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $userToken",
    };
  }

  Future<Response> fetchData(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      return await dioInstance.get(
        endpoint,
        queryParameters: params,
      );
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchDataMap(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      Response<dynamic> response = await dioInstance.get(
        endpoint,
        queryParameters: params,
      );

      // Extract data from the response
      Map<String, dynamic> responseData = response.data;

      return responseData;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<bool> isInternetWorking() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> downloadCachedImage(String url) async {
    await _cacheManager.downloadFile(url);
  }

  CachedNetworkImage getCachedNetworkImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Future<File> getFile(String url) async {
    File file = await _cacheManager.getSingleFile(url);
    return file;
  }

  Future<List<Articles2>> getCachedArticles2() async {
    final cacheDir = await getTemporaryDirectory();
    final file = File('${cacheDir.path}/cached_articles2.json');

    if (file.existsSync()) {
      final jsonData = await file.readAsString();
      final List<dynamic> jsonList = json.decode(jsonData);
      final List<Articles2> cachedArticles2 = jsonList
          .map((item) => Articles2.fromJson(item))
          .toList();
      return cachedArticles2;
    } else {
      return [];
    }
  }

  Future<void> saveListToFile(String fileName, List<dynamic> dataList) async {
    final cacheDir = await getTemporaryDirectory();
    final file = File('${cacheDir.path}/$fileName');
    await file.writeAsString(json.encode(dataList));
  }

  Future<List<ArticleContent>> getCachedArticleContent() async {
    final cacheDir = await getTemporaryDirectory();
    final file = File('${cacheDir.path}/article_content.json');

    if (file.existsSync()) {
      final jsonData = await file.readAsString();
      final List<dynamic> jsonList = json.decode(jsonData);
      final List<ArticleContent> cachedArticleContent = jsonList
          .map((item) => ArticleContent.fromJson(item))
          .toList();
      return cachedArticleContent;
    } else {
      return [];
    }
  }

  Future<List<ListItem>> getCachedListItem() async {
    final cacheDir = await getTemporaryDirectory();
    final file = File('${cacheDir.path}/cached_list_items.json');

    if (file.existsSync()) {
      final jsonData = await file.readAsString();
      final List<dynamic> jsonList = json.decode(jsonData);
      final List<ListItem> cachedListItems = jsonList
          .map((item) => ListItem.fromJson(item))
          .toList();
      return cachedListItems;
    } else {
      return [];
    }
  }

  Future<List<Quotes2Content>> getCachedQuotes2() async {
    final cacheDir = await getTemporaryDirectory();
    final file = File('${cacheDir.path}/cached_quotes2_content.json');

    if (file.existsSync()) {
      final jsonData = await file.readAsString();
      final List<dynamic> jsonList = json.decode(jsonData);
      final List<Quotes2Content> cachedQuotes2Content = jsonList
          .map((item) => Quotes2Content.fromJson(item))
          .toList();
      return cachedQuotes2Content;
    } else {
      return [];
    }
  }

  Future<List<Video>> getCachedVideo() async {
    final cacheDir = await getTemporaryDirectory();
    final file = File('${cacheDir.path}/cached_videos.json');

    if (file.existsSync()) {
      final jsonData = await file.readAsString();
      final List<dynamic> jsonList = json.decode(jsonData);
      final List<Video> cachedVideos = jsonList
          .map((item) => Video.fromJson(item))
          .toList();
      return cachedVideos;
    } else {
      return [];
    }
  }



}
