import 'package:blog_app/home/cubit/post_cubit.dart';
import 'package:blog_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

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
    postCubit.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Home",
            style: theme.textTheme.headline1,
          ),
          state.posts != null
              ? Expanded(
                  child: ListView.separated(
                      itemBuilder: (cotext, index) {
                        return ListTile(
                          onTap: () {
                            print("글로 이동");
                          },
                          contentPadding: EdgeInsets.zero,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "@${state.posts![index].author}",
                                style: theme.textTheme.subtitle2!
                                    .copyWith(height: 1.5),
                              ),
                              Text(
                                "${state.posts![index].title}",
                                style: theme.textTheme.headline2!
                                    .copyWith(height: 1.5),
                              ),
                            ],
                          ),
                          subtitle: Text("${state.posts![index].createAt}"),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
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
