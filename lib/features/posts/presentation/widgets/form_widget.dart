import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:posts/features/posts/domain/entity/post.dart';
import 'package:posts/features/posts/presentation/bloc/posts_crud/posts_crud_bloc.dart';
import 'package:posts/features/posts/presentation/widgets/app_elevated_button_widget.dart';

import 'app_text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final Post? post;
  const FormWidget({super.key, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.post != null) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _validateFormAndConfirm() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final Post post = Post(
        id: widget.post?.id,
        title: _titleController.text,
        body: _bodyController.text,
      );
      if (widget.post != null) {
        BlocProvider.of<PostsCrudBloc>(context)
            .add(UpdatePostsCrudEvent(post: post));
      } else {
        BlocProvider.of<PostsCrudBloc>(context)
            .add(CreatePostsCrudEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTextFormFieldWidget(
            controller: _titleController,
            hint: 'Title',
          ),
          AppTextFormFieldWidget(
            controller: _bodyController,
            hint: 'Body',
            lines: 6,
          ),
          AppElevatedButtonWidget(
            title: widget.post != null ? "Edit" : "Add",
            icon: widget.post != null ? Icons.edit : Icons.add,
            onPressed: _validateFormAndConfirm,
          ),
        ],
      ),
    );
  }
}
