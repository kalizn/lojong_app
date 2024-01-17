import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lojong_app/viewmodels/home/home.viewmodel.dart';
import 'package:provider/provider.dart';
import 'utils/routes.dart';
import 'utils/theme.dart';
import 'views/splash/splash.view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [ChuckerFlutter.navigatorObserver],
        title: 'Lojong App',
        theme: AppTheme.lightTheme(context),
        initialRoute: SplashView.routeName,
        routes: routes);
  }
}
