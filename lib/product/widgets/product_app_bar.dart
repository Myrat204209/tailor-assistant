// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ProductAppBar extends StatelessWidget {
  const ProductAppBar({
    required this.onIconClick,
    required this.title,
    super.key,
  });
  final VoidCallback onIconClick;
  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppIconButton(
          foregroundColor: colorScheme.onSurface,
          backgroundColor: colorScheme.surface,
          onIconPressed: onIconClick,
          icon: Icons.west_rounded,
        ),
        Text(
          title,
          style: const AppTextStyle.text().pageTitle(),
        ),
      ],
    ).paddingSymmetric(horizontal: 20, vertical: 30);
  }
}
