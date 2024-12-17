// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// App Circle Icon Button
class AppIconButton extends StatelessWidget {
  /// Constructor
  const AppIconButton({
    required this.foregroundColor,
    required this.backgroundColor,
    required this.onIconPressed,
    required this.icon,
    this.onLongPressed,
    super.key,
  });
  final Color foregroundColor;
  final Color backgroundColor;
  final VoidCallback onIconPressed;
  final VoidCallback? onLongPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPressed,
      child: IconButton.filled(
        padding: const EdgeInsets.all(15),
        style: IconButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        onPressed: onIconPressed,
        icon: Icon(
          icon,
          size: 30,
        ),
      ).paddingOnly(right: 10),
    );
  }
}
