part of 'post_cubit.dart';

class PostState extends Equatable {
  const PostState({this.posts});

  final List<Post>? posts;

  @override
  List<Object?> get props => [posts];

  PostState copyWith({
    List<Post>? posts,
  }) {
    return PostState(posts: posts ?? this.posts);
  }
}
