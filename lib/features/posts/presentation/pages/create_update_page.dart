import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/core/utils/show_snackbar.dart';
import 'package:posts/core/widgets/loading_widget.dart';
import 'package:posts/features/posts/domain/entity/post.dart';
import 'package:posts/features/posts/presentation/bloc/posts_crud/posts_crud_bloc.dart';
import 'package:posts/features/posts/presentation/pages/home_page.dart';

import '../widgets/form_widget.dart';

class CreateAndUpdatePage extends StatelessWidget {
  final Post? post;

  const CreateAndUpdatePage({
    super.key,
    this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(post != null ? "Edit Post" : "Create Post"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: BlocConsumer<PostsCrudBloc, PostsCrudState>(
        listener: (context, state) {
          if (state is PostsCrudSuccessState) {
            // snackbar
            ShowSnackbar().success(
              context: context,
              message: state.message,
            );
            // navigate to home page
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false,
            );
          } else if (state is PostsCrudErrorState) {
            // snackbar
            ShowSnackbar().error(
              context: context,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          if (state is PostsCrudLoadingState) {
            return const LoadingWidget();
          }
          if (post != null) {
            return FormWidget(post: post!);
          } else {
            return const FormWidget();
          }
        },
      ),
    );
  }
}
