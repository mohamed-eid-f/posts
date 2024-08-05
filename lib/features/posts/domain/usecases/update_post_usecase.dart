import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entity/post.dart';
import '../repositories/posts_repository.dart';

class UpdatePostUsecase {
  final PostsRepository repository;

  UpdatePostUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
