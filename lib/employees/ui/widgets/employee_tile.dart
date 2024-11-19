// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class SewerTile extends StatelessWidget {
  const SewerTile({
    required this.name,
    required this.onTap,
    super.key,
  });
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      tileColor: colorScheme.surface,
      title: Text(
        name,
        style: const AppTextStyle.text().contentTitle(),
      ).paddingSymmetric(vertical: 16, horizontal: 14),
      trailing: IconButton.filled(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          foregroundColor: colorScheme.tertiary,
          backgroundColor: colorScheme.onTertiary,
        ),
        icon: const Icon(Icons.east_sharp, size: 35)
            .paddingAll(12)
            .paddingOnly(bottom: 5),
      ).paddingOnly(right: 14),
      contentPadding: EdgeInsets.zero,
      shape: ShapeBorderX.roundedRectangle(15),
    );
  }
}
