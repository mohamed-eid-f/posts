import 'package:dartz/dartz.dart';

import 'package:posts/core/errors/failure.dart';
import 'package:posts/features/posts/domain/entity/post.dart';
import 'package:posts/features/posts/domain/repositories/posts_repository.dart';

class GetAllPostsUsecase {
  final PostsRepository repository;
  GetAllPostsUsecase({
    required this.repository,
  });

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
