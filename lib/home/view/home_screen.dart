import 'package:blog_app/post/cubit/post_cubit.dart';
import 'package:blog_app/post/view/editor_page.dart';
import 'package:blog_app/repositories/post_repository/src/post_repository.dart';
import 'package:blog_app/repositories/user_repository/src/firebase_user_repository.dart';
import 'package:blog_app/repositories/user_repository/src/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  late FirebaseUserRepository _firebaseUserRepository;
  CollectionReference posting =
      FirebaseFirestore.instance.collection('posting');

  late PostCubit postCubit;

  @override
  void initState() {
    super.initState();
    _firebaseUserRepository = RepositoryProvider.of<FirebaseUserRepository>(context);
    postCubit = PostCubit(RepositoryProvider.of<PostRepository>(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => BlocProvider<PostCubit>.value(
                value: postCubit,
                child: PostingPage(),
              ),
            ));
          },
          child: Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SafeArea(
            child: BlocProvider.value(
          value: postCubit,
          child: HomePage(),
        )),
      ),
    );
  }
}
