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

  TextEditingController _titleController = TextEditingController();
  QuillController _controller = QuillController.basic();
  bool isEdit = false;
  late String title;

  @override
  void initState() {
    super.initState();
    postCubit = BlocProvider.of<PostCubit>(context);
    var contentJson = jsonDecode(post.content!);
    _controller = QuillController(
        document: Document.fromJson(contentJson),
        selection: TextSelection.collapsed(offset: 0));
    title = post.title!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              if (isEdit) {
                var content =
                    jsonEncode(_controller.document.toDelta().toJson());
                postCubit.updatePost(post, title, content);

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title:
                            Text("글이 수정되었습니다.", style: theme.textTheme.button),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("확인"),
                          ),
                        ],
                      );
                    });
              }

              setState(() {
                isEdit = !isEdit;
              });
            },
            child: Container(
                padding: EdgeInsets.only(right: 30),
                alignment: Alignment.center,
                child:
                    Text(isEdit ? "완료" : "수정", style: theme.textTheme.button)),
          ),
          GestureDetector(
            onTap: () {
              postCubit.deletePost(post.id!);
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("글이 삭제되었습니다.", style: theme.textTheme.button),
                      actions: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text("확인"),
                        ),
                      ],
                    );
                  });
            },
            child: Container(
                padding: EdgeInsets.only(right: 20),
                alignment: Alignment.center,
                child: Text("삭제", style: theme.textTheme.button)),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: post.title,
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                      style: theme.textTheme.headline1,
                      readOnly: !isEdit,
                      maxLines: null,
                      cursorColor: theme.accentColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    Text("@${post.author}", style: theme.textTheme.subtitle1),
                    Text("${post.createAt}", style: theme.textTheme.subtitle2),
                    Divider(
                      color: Colors.grey[300],
                    )
                  ],
                ),
              ),
              Visibility(visible: isEdit, child:  QuillToolbar.basic(controller: _controller)),
              Container(
                child: QuillEditor.basic(
                  controller: _controller,
                  readOnly: !isEdit,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
