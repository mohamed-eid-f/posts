part of 'posts_crud_bloc.dart';

sealed class PostsCrudState extends Equatable {
  const PostsCrudState();

  @override
  List<Object> get props => [];
}

final class PostsCrudInitialState extends PostsCrudState {}
final class PostsCrudLoadingState extends PostsCrudState {}

final class PostsCrudSuccessState extends PostsCrudState {
  final String message;

  const PostsCrudSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class PostsCrudErrorState extends PostsCrudState {
  final String message;

  const PostsCrudErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
