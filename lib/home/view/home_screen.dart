import 'package:blog_app/repositories/user_repository/src/user_repository.dart';
import 'package:blog_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'home_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _userRepository = RepositoryProvider.of<UserRepository>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {
            Navigator.pushNamed(context, 'posting_page');

          }, child: Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SafeArea(child: HomePage()),
      ),
    );
  }
}
