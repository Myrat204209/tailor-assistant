// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class EmployeeTile extends StatelessWidget {
  const EmployeeTile({
    required this.name,
    required this.quantity,
    required this.onTap,
    super.key,
  });
  final String name;
  final int quantity;
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
          EmployeeTileIcons(
            onPressed: () {},
            quantity: quantity,
          ),
          EmployeeTileIcons(
            onPressed: onTap,
            icon: Icons.east_sharp,
          )
        ],
      ),
      contentPadding: EdgeInsets.zero,
      shape: ShapeBorderX.roundedRectangle(15),
    );
  }
}

class EmployeeTileIcons extends StatelessWidget {
  const EmployeeTileIcons({
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
