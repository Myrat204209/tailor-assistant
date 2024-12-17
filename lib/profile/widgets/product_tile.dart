// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    required this.colorScheme,
    required this.onDeleteTap,
    required this.onEditTap,
    required this.title,
    required this.docNumber,
    super.key,
  });
  final ColorScheme colorScheme;
  final VoidCallback onDeleteTap;
  final VoidCallback onEditTap;
  final String docNumber;
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      docNumber,
                      softWrap: true,
                      style: const AppTextStyle.text()
                          .description()
                          .withColor(colorScheme.shadow),
                    ),
                    Text(
                      title,
                      softWrap: true,
                      style: const AppTextStyle.text().contentTitle(),
                    ).paddingOnly(bottom: 10),
                  ],
                ),
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
