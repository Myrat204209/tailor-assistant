// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class OperationAppBar extends StatelessWidget {
  const OperationAppBar({
    required this.title,
    required this.docNumber,
    required this.onIconClick,
    super.key,
  });
  final String title;
  final String docNumber;
  final VoidCallback onIconClick;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppIconButton(
              foregroundColor: colorScheme.onSurface,
              backgroundColor: colorScheme.surface,
              onIconPressed: onIconClick,
              icon: Icons.west_rounded,
            ),
            Text(
              docNumber,
              softWrap: true,
              style: const AppTextStyle.text()
                  .pageTitleBold()
                  .withColor(colorScheme.primary),
            ),
          ],
        ),
        Text(
          // orderItem.itemName,
          title,
          softWrap: true,
          style: const AppTextStyle.text().pageTitle(),
        )
      ],
    ).paddingSymmetric(horizontal: 20, vertical: 30);
  }
}
