import 'package:blog_app/post/cubit/post_cubit.dart';
import 'package:blog_app/post/view/post_detail_page.dart';
import 'package:blog_app/support/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PostCubit postCubit;

  @override
  void initState() {
    super.initState();
    postCubit = BlocProvider.of<PostCubit>(context);
    postCubit.getAllPosts(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/blog-logo-shape.png', width: 50),
          Text(
            "Home",
            style: theme.textTheme.headline1,
          ),
          Container(
            child: Wrap(
              spacing: 5,
              direction: Axis.horizontal,
              children: [
                ElevatedButton(
                  onPressed: () {
                    postCubit.getAllPosts(false);
                  },
                  child: Text('최신 순'),
                  style: ElevatedButton.styleFrom( shape: StadiumBorder(), elevation:0, primary: Color(0xFF2A64D3)),
                ),
                ElevatedButton(
                  onPressed: () {
                    postCubit.getAllPosts(true);
                  },
                  child: Text('오래된 순'),
                  style: ElevatedButton.styleFrom(shape: StadiumBorder(), elevation:0, primary: Color(0xFF2A64D3)),
                )
              ],
            ),
          ),
          state.posts != null && state.posts!.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                      itemBuilder: (cotext, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                          value: postCubit,
                                          child: PostDetailPage(
                                              state.posts![index]),
                                        )));
                          },
                          contentPadding: EdgeInsets.zero,
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text("${state.posts![index].title}",
                                style: theme.textTheme.headline1!
                                    .copyWith(fontSize: 25)),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                  visible:
                                      state.posts![index].plainContent != null,
                                  child: Text(
                                    "${state.posts![index].plainContent}",
                                    maxLines: 3,
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "@${state.posts![index].author}  ",
                                    style: theme.textTheme.subtitle2!
                                        .copyWith(height: 1.5),
                                  ),
                                  Text("${state.posts![index].createAt}"),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: Colors.grey,
                        );
                      },
                      itemCount: state.posts!.length))
              : Container(
                  height: 300,
                  alignment: Alignment.center,
                  child: Text("등록된 게시글이 없습니다."))
        ],
      );
    });
  }
}
