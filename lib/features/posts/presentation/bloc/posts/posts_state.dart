part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsLoadingState extends PostsState {}

final class PostsSuccessState extends PostsState {
  final List<Post> postsList;

  const PostsSuccessState({required this.postsList});
  @override
  List<Object> get props => [postsList];
}

final class PostsErrorState extends PostsState {
  final String errorMessage;

  const PostsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
