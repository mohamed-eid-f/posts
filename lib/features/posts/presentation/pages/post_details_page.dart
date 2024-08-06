import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/core/utils/show_snackbar.dart';
import 'package:posts/core/widgets/loading_widget.dart';
import 'package:posts/features/posts/domain/entity/post.dart';
import 'package:posts/features/posts/presentation/bloc/posts_crud/posts_crud_bloc.dart';
import 'package:posts/features/posts/presentation/pages/create_update_page.dart';
import 'package:posts/features/posts/presentation/pages/home_page.dart';
import 'package:posts/features/posts/presentation/widgets/app_elevated_button_widget.dart';

import '../widgets/delete_dialog_widget.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;
  const PostDetailsPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              post.body,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppElevatedButtonWidget(
                  title: "edit",
                  icon: Icons.edit,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CreateAndUpdatePage(
                          post: post,
                        ),
                      ),
                    );
                  },
                ),
                AppElevatedButtonWidget(
                  title: "delete",
                  icon: Icons.delete_forever_rounded,
                  color: Colors.redAccent,
                  onPressed: () => deleteDialog(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<PostsCrudBloc, PostsCrudState>(
            listener: (context, state) {
              if (state is PostsCrudSuccessState) {
                ShowSnackbar().success(
                  context: context,
                  message: state.message,
                );
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const HomePage(),
                  ),
                  (_) => false,
                );
              } else if (state is PostsCrudSuccessState) {
                Navigator.of(context).pop();
                ShowSnackbar().success(
                  context: context,
                  message: state.message,
                );
              }
            },
            builder: (context, state) {
              if (state is PostsCrudLoadingState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: post.id!);
            },
          );
        });
  }
}
