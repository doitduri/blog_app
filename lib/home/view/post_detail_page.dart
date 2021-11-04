import 'dart:convert';

import 'package:blog_app/home/cubit/post_cubit.dart';
import 'package:blog_app/repositories/post_repository/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../theme.dart';

class PostDetailPage extends StatefulWidget {
  PostDetailPage(this.post);

  final Post post;

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage>
    with SingleTickerProviderStateMixin {
  Post get post => this.widget.post;
  late PostCubit postCubit;

  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    postCubit = BlocProvider.of<PostCubit>(context);
    var contentJson = jsonDecode(post.content!);
    print(contentJson);
    print(post.content);
    _controller = QuillController(
        document: Document.fromJson(contentJson),
        selection: TextSelection.collapsed(offset: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("@${post.author}", style: theme.textTheme.subtitle1),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text("${post.title}", style: theme.textTheme.headline1),
              ),
              Container(
                child: QuillEditor.basic(
                  controller: _controller,
                  readOnly: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
