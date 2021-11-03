import 'package:flutter/material.dart';

import 'home/view/editor_page.dart';
import 'home/view/views.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  PostingPage.routeName: (context) => PostingPage(),
};
