import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/features/posts/presentation/bloc/posts_crud/posts_crud_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;
  const DeleteDialogWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure ?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<PostsCrudBloc>(context).add(
              DeletePostsCrudEvent(postId: postId),
            );
            // Navigator.of(context).pop();
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
