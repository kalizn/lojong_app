import 'package:flutter/cupertino.dart';

import '../views/home/components/article_show_all_content.dart';
import '../views/home/components/quote_content.dart';
import '../views/home/components/web_view_page.dart';
import '../views/home/home.view.dart';
import '../views/splash/splash.view.dart';

final Map<String, WidgetBuilder> routes = {
  SplashView.routeName: (context) => const SplashView(),
  HomeView.routeName: (context) =>  const HomeView(),
  WebViewPage.routeName: (context) => const WebViewPage(),
  ArticleShowAllContent.routeName: (context) => const ArticleShowAllContent(),
  QuotesPage.routeName: (context) => const QuotesPage(),
};