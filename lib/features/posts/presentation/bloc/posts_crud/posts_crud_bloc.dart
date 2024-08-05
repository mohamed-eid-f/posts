import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/strings/failure_strings.dart';
import '../../../../../core/strings/success_strings.dart';
import '../../../domain/entity/post.dart';
import '../../../domain/usecases/create_post_usecase.dart';
import '../../../domain/usecases/delete_post_usecase.dart';
import '../../../domain/usecases/update_post_usecase.dart';

part 'posts_crud_event.dart';
part 'posts_crud_state.dart';

class PostsCrudBloc extends Bloc<PostsCrudEvent, PostsCrudState> {
  final CreatePostUsecase createPostUsecase;
  final UpdatePostUsecase updatePostUsecase;
  final DeletePostUsecase deletePostUsecase;

  PostsCrudBloc({
    required this.createPostUsecase,
    required this.updatePostUsecase,
    required this.deletePostUsecase,
  }) : super(PostsCrudLoadingState()) {
    on<PostsCrudEvent>((event, emit) async {
      switch (event) {
        case CreatePostsCrudEvent():
          emit(PostsCrudLoadingState());
          final either = await createPostUsecase(event.post);
          emit(_getState(either, CREATE_SUCCESS_MESSAGE));

        case UpdatePostsCrudEvent():
          emit(PostsCrudLoadingState());
          final either = await updatePostUsecase(event.post);
          emit(_getState(either, UPDATE_SUCCESS_MESSAGE));

        case DeletePostsCrudEvent():
          emit(PostsCrudLoadingState());
          final either = await deletePostUsecase(event.postId);
          emit(_getState(either, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  PostsCrudState _getState(Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => PostsCrudErrorState(message: getErrorMessage(failure)),
      (_) => PostsCrudSuccessState(message: message),
    );
  }
}

String getErrorMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure():
      return SERVER_FAILURE_MESSAGE;
    case OfflineFailure():
      return OFFLINE_FAILURE_MESSAGE;
    case EmptyCacheFailure():
      return EMPTYCACHE_FAILURE_MESSAGE;
    default:
      return "Unexpected Error. Please try again later";
  }
}
