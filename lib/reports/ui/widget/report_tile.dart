// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ReportTile extends StatelessWidget {
  const ReportTile({
    required this.name,
    required this.reportsCount,
    required this.onTap,
    super.key,
  });
  final String name;
  final int reportsCount;
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ReportTileIcons(
            quantity: reportsCount,
            onPressed: () {},
          ),
          ReportTileIcons(
            icon: Icons.east_rounded,
            onPressed: onTap,
          ),
        ],
      ).paddingOnly(right: 14),
      contentPadding: EdgeInsets.zero,
      shape: ShapeBorderX.roundedRectangle(15),
    );
  }
}

class ReportTileIcons extends StatelessWidget {
  const ReportTileIcons({
    required this.onPressed,
    super.key,
    this.icon,
    this.quantity,
  });

  final VoidCallback onPressed;
  final IconData? icon;
  final int? quantity;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        shape: const CircleBorder(),
        iconColor: colorScheme.tertiary,
        padding: EdgeInsets.zero,
        fixedSize: const Size.square(60),
        backgroundColor:
            icon != null ? colorScheme.onTertiary : colorScheme.onSecondary,
      ),
      onPressed: onPressed,
      label: icon != null
          ? Icon(icon, size: 35)
          : Text(
              '$quantity',
              style: const AppTextStyle.text()
                  .contentTitle()
                  .withColor(colorScheme.secondary),
            ),
    );
  }
}
