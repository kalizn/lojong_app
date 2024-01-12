import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/connection.dart';
import 'utils/routes.dart';
import 'utils/theme.dart';
import 'viewmodels/home/home.video.viewmodel.dart';
import 'views/splash/splash.view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeVideoViewModel(connection: Connection())),
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
      title: 'Lojong App',
      theme: AppTheme.lightTheme(context),
      initialRoute: SplashView.routeName,
      routes: routes
    );
  }
}
