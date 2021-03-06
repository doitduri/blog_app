import 'dart:convert';

import 'package:blog_app/post/cubit/post_cubit.dart';
import 'package:blog_app/repositories/post_repository/models/post.dart';
import 'package:blog_app/support/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import 'comment_page.dart';

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

  FocusNode focusNode = FocusNode();

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              if (isEdit) {
                var content = jsonEncode(_controller.document.toDelta().toJson());
                var plainContent = _controller.document.toPlainText();

                postCubit.updatePost(post, title, content, plainContent);

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title:
                            Text("?????? ?????????????????????.", style: theme.textTheme.button),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("??????"),
                          ),
                        ],
                      );
                    });
              }

              setState(() {
                isEdit = !isEdit;
                focusNode.requestFocus();
              });
            },
            child: Container(
                padding: EdgeInsets.only(right: 30),
                alignment: Alignment.center,
                child:
                    Text(isEdit ? "??????" : "??????", style: theme.textTheme.button)),
          ),
          GestureDetector(
            onTap: () {
              postCubit.deletePost(post.id!);
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("?????? ?????????????????????.", style: theme.textTheme.button),
                      actions: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text("??????"),
                        ),
                      ],
                    );
                  });
            },
            child: Container(
                padding: EdgeInsets.only(right: 20),
                alignment: Alignment.center,
                child: Text("??????", style: theme.textTheme.button)),
          )
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              builder: (context) => BlocProvider<PostCubit>.value(
                    value: postCubit,
                    child: CommentPage(post),
                  ),
              isScrollControlled: true);
        },
        child: Container(
          height: 100,
          color: theme.primaryColor,
          child: Center(
              child: Text("?????? ?????????",
                  style:
                      theme.textTheme.button!.copyWith(color: Colors.white))),
        ),
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
                      focusNode: focusNode,
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
              Visibility(
                  visible: isEdit,
                  child: QuillToolbar.basic(controller: _controller)),
              Container(
                margin: EdgeInsets.only(bottom: 110),
                child: QuillEditor(
                  controller: _controller,
                  readOnly: !isEdit,
                  expands: false,
                  scrollController: ScrollController(),
                  autoFocus: isEdit,
                  scrollable: true,
                  focusNode: FocusNode(),
                  padding: EdgeInsets.zero,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
