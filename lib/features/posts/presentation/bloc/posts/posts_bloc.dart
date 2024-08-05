import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/strings/failure_strings.dart';
import '../../../domain/entity/post.dart';
import '../../../domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  GetAllPostsUsecase getAllPostsUsecase;

  PostsBloc({
    required this.getAllPostsUsecase,
  }) : super(PostsLoadingState()) {
    on<PostsEvent>((event, emit) async {
      switch (event) {
        case GetAllPostsEvent():
          emit(PostsLoadingState());
          final either = await getAllPostsUsecase.call();
          emit(_getState(either));
          break;
        case RefreshPostsEvent():
          emit(PostsLoadingState());
          final either = await getAllPostsUsecase.call();
          emit(_getState(either));
          break;
      }
    });
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

PostsState _getState(Either<Failure, List<Post>> either) {
  return either.fold(
    (failure) => PostsErrorState(errorMessage: getErrorMessage(failure)),
    (postsList) => PostsSuccessState(postsList: postsList),
  );
}
