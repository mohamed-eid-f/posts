import 'package:dartz/dartz.dart';

import 'package:posts/core/errors/exceptions.dart';
import 'package:posts/core/errors/failure.dart';
import 'package:posts/core/network/internet_info.dart';
import 'package:posts/features/posts/data/datasources/post_local_data_source.dart';
import 'package:posts/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:posts/features/posts/data/models/post_model.dart';
import 'package:posts/features/posts/domain/entity/post.dart';
import 'package:posts/features/posts/domain/repositories/posts_repository.dart';

typedef CrudFunction = Future<Unit> Function();
 
class PostRepositoryImpl implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final InternetInfo internetInfo;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.internetInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await internetInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        await localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> createPost(Post post) async {
    final postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() => remoteDataSource.createPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() => remoteDataSource.deletePost(postId));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() => remoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(CrudFunction crudFunction) async {
    if (await internetInfo.isConnected) {
      try {
        crudFunction();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
