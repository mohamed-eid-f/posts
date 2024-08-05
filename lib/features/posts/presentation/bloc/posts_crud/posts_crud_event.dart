part of 'posts_crud_bloc.dart';

sealed class PostsCrudEvent extends Equatable {
  const PostsCrudEvent();

  @override
  List<Object> get props => [];
}

class CreatePostsCrudEvent extends PostsCrudEvent {
  final Post post;

  const CreatePostsCrudEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class UpdatePostsCrudEvent extends PostsCrudEvent {
  final Post post;

  const UpdatePostsCrudEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class DeletePostsCrudEvent extends PostsCrudEvent {
  final int postId;

  const DeletePostsCrudEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}
