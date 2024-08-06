import 'package:flutter/material.dart';

class PostsErrorWidget extends StatelessWidget {
  final String message;
  const PostsErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
