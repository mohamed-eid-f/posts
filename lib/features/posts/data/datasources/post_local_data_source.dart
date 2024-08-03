import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:posts/features/posts/data/models/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

const CACHED_POSTS = 'CACHED_POSTS';

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) async {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    await sharedPreferences.setString(
        CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() async {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> postModels = decodeJsonData
          .map((jsonModel) => PostModel.fromJson(jsonModel))
          .toList();
      return Future.value(postModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
