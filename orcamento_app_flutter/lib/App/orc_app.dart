import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'pages/main_page.dart';
import 'pages/splash/splash_page.dart';

class OrcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetIt.I.allReady(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SplashPage();
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'OrçApp',
            //theme: ThemeService.getTheme(ThemeType.defaultTheme),
            initialRoute: '/',
            routes: {
              '/': (_) => MainPage(title: 'OrçApp'),
            },
          );
        });
  }
}
