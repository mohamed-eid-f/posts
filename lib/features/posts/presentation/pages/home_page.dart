import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/features/posts/presentation/pages/create_update_page.dart';

import '../bloc/posts/posts_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/posts_error_widget.dart';
import '../widgets/posts_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFAB(context),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: const Text("Posts"),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsSuccessState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostsListWidget(posts: state.postsList),
            );
          } else if (state is PostsErrorState) {
            return PostsErrorWidget(message: state.errorMessage);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const CreateAndUpdatePage()));
      },
      child: const Icon(Icons.add),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent());
  }
}
