import 'package:dartz/dartz.dart';
import 'package:posts/core/errors/failure.dart';
import 'package:posts/features/posts/domain/entity/post.dart';
import 'package:posts/features/posts/domain/repositories/posts_repository.dart';

class CreatePostUsecase {
  final PostsRepository repository;

  CreatePostUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.createPost(post);
  }
}
