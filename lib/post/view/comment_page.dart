import 'package:blog_app/post/cubit/post_cubit.dart';
import 'package:blog_app/repositories/post_repository/models/post.dart';
import 'package:blog_app/support/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentPage extends StatefulWidget {
  CommentPage(this.post);

  final Post post;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage>
    with SingleTickerProviderStateMixin {
  Post get post => this.widget.post;

  late PostCubit postCubit;
  final TextEditingController _messageController = TextEditingController();
  late int index;

  @override
  void initState() {
    super.initState();
    postCubit = BlocProvider.of<PostCubit>(context);
    index = postCubit.state.posts!.indexWhere((p)=>p.id == post.id);
  }

  @override
  Widget build(BuildContext context) {
    _messageController.text = "";
    return SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            padding: EdgeInsets.all(30),
            child: SafeArea(child:
                BlocBuilder<PostCubit, PostState>(builder: (context, state) {
              return Column(children: [
                Flexible(
                    child: Container(
                  child: TextFormField(
                    controller: _messageController,
                    scrollPadding: EdgeInsets.only(bottom: 40),
                    onFieldSubmitted: (value) {
                      postCubit.addPostComment(postCubit.state.posts![index],
                          _messageController.text);
                      setState(() {
                        _messageController.text = "";
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "댓글을 입력해주세요!",
                        suffixIcon: MaterialButton(
                          onPressed: () {
                            postCubit.addPostComment(
                                postCubit.state.posts![index],
                                _messageController.text);
                            setState(() {
                              _messageController.text = "";
                            });
                          },
                          minWidth: 50,
                          height: 50,
                          child: Text("등록",
                              style: TextStyle(color: theme.primaryColor)),
                        )),
                  ),
                )),
                BlocSelector<PostCubit, PostState, List<Post>?>(
                    selector: (state) => state.posts,
                    builder: (context, posts) {
                      print("posts![index].comments!.length ${posts![index].comments}");
                      return Flexible(
                          flex: 9,
                          child: posts[index].comments == null ||
                              (posts[index].comments!.isEmpty && posts[index].comments != null)
                              ? Center(child: Text("🥲 댓글이 없습니다."))
                              : ListView.separated(
                            itemBuilder: (context, i) {
                              return ListTile(
                                title: Text(
                                    "${posts[index].comments![i]["content"]}"),
                                subtitle: Text(
                                  "${posts[index].comments![i]["createAt"]}",
                                  style: theme.textTheme.caption,
                                ),
                                trailing: GestureDetector(
                                    onTap: () {
                                      print("삭제 $i");
                                      postCubit.deletePostComment(
                                          index, post, i);
                                    },
                                    child: Text("삭제")),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                            itemCount: posts[index].comments!.length,
                          ));
                    }),
              ]);
            }))));
  }
}
