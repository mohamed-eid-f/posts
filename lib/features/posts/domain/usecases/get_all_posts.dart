import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entity/post.dart';
import '../repositories/posts_repository.dart';

class GetAllPostsUsecase {
  final PostsRepository repository;
  GetAllPostsUsecase({
    required this.repository,
  });

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
