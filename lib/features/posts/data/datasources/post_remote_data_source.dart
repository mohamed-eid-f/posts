import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts/core/errors/exceptions.dart';
import 'package:posts/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> createPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> deletePost(int postId);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceWithHttp implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceWithHttp({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse("$BASE_URL/posts/"),
      headers: {
        "content-type": "application/json",
      },
    );

    if (response.statusCode >= 200) {
      final List decodedJson = json.decode(response.body) as List;
      List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostMode) => PostModel.fromJson(jsonPostMode))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> createPost(PostModel postModel) async {
    final Map<String, dynamic> body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response = await client.post(
      Uri.parse("$BASE_URL/posts/"),
      body: body,
    );
    if (response.statusCode >= 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse("$BASE_URL/posts/$postId"),
      headers: {
        "content-type": "application/json",
      },
    );
    if (response.statusCode >= 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final Map<String, dynamic> body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response = await client.put(
      Uri.parse("$BASE_URL/posts/${postModel.id}"),
      body: body,
    );
    if (response.statusCode >= 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}

// PostRemoteDataSourceWithDio