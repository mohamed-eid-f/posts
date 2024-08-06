import 'package:flutter/material.dart';
import 'package:posts/core/theme/app_theme.dart';

class AppElevatedButtonWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Function() onPressed;

  const AppElevatedButtonWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.color = secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(title),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
      ),
    );
  }
}
