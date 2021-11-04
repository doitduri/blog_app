import 'dart:convert';

import 'package:blog_app/post/cubit/post_cubit.dart';
import 'package:blog_app/support/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class PostingPage extends StatefulWidget {
  static String routeName = 'posting_page';

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {

  TextEditingController _titleController = TextEditingController();
  QuillController _controller = QuillController.basic();

  late PostCubit _postCubit;

  @override
  void initState() {
    super.initState();
    _postCubit = BlocProvider.of<PostCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                if(_titleController.text.isNotEmpty){
                  var title = _titleController.text.toString();
                  var content = jsonEncode(_controller.document.toDelta().toJson());

                  _postCubit.addPost(title, content);


                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text("글이 등록되었습니다.", style: theme.textTheme.button),
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
                }
              },
              child: Container(
                  padding: EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  child: Text("글쓰기", style: theme.textTheme.button)),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  style: theme.textTheme.headline2,
                  cursorColor: theme.accentColor,
                  decoration: InputDecoration(
                    hintText: "제목을 입력해주세요.",
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 15),
                QuillToolbar.basic(controller: _controller),
                Expanded(
                  child: Container(
                    child: QuillEditor.basic(
                      controller: _controller,
                      readOnly: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
