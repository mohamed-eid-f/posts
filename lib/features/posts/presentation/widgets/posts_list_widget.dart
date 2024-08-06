import 'package:flutter/material.dart';
import 'package:posts/features/posts/presentation/pages/post_details_page.dart';
import '../../domain/entity/post.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostsListWidget({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => ListTile(
        leading: Text(posts[index].id.toString()),
        title: Text(
          posts[index].title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          posts[index].body,
          style: const TextStyle(fontSize: 16),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PostDetailsPage(
                post: posts[index],
              ),
            ),
          );
        },
      ),
      separatorBuilder: (_, __) => const Divider(thickness: 1),
      itemCount: posts.length,
    );
  }
}
