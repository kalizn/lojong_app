import 'package:flutter/cupertino.dart';

import '../views/home/home.view.dart';
import '../views/splash/splash.view.dart';

final Map<String, WidgetBuilder> routes = {
  SplashView.routeName: (context) => const SplashView(),
  HomeView.routeName: (context) =>  HomeView()
};