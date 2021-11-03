
import 'package:blog_app/theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Home", style: theme.textTheme.headline1,),
        Text("포스팅 내용 적어야해",),
      ],
    );
  }
}