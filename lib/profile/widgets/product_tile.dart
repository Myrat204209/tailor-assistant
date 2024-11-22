// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    required this.colorScheme,
    required this.onDeleteTap,
    required this.onEditTap,
    required this.title,
    super.key,
  });
  final ColorScheme colorScheme;
  final VoidCallback onDeleteTap;
  final VoidCallback onEditTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  softWrap: true,
                  style: const AppTextStyle.text().contentTitle(),
                ).paddingAll(20),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIconButton(
                    foregroundColor: colorScheme.onError,
                    backgroundColor: colorScheme.error,
                    onIconPressed: onDeleteTap,
                    icon: Icons.delete_outlined,
                  ),
                  AppIconButton(
                    foregroundColor: colorScheme.secondary,
                    backgroundColor: colorScheme.onSecondary,
                    onIconPressed: onEditTap,
                    icon: Icons.edit_rounded,
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(vertical: 10),
        ).colorize(colorScheme.surface),
        Divider(
          height: 0.1,
          color: colorScheme.onPrimary,
        ),
      ],
    );
  }
}
