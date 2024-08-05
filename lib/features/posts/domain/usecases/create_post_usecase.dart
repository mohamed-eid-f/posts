import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entity/post.dart';
import '../repositories/posts_repository.dart';

class CreatePostUsecase {
  final PostsRepository repository;

  CreatePostUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.createPost(post);
  }
}
