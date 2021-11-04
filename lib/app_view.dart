
import 'package:blog_app/support/routes.dart';
import 'package:blog_app/support/theme.dart';
import 'package:flutter/material.dart';


class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), //set desired text scale factor here
          child: child!,
        );
      },
      initialRoute: 'home_screen',
      routes: routes,
    );
  }

}
