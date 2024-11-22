import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppIconButton(
              foregroundColor: colorScheme.onSurface,
              backgroundColor: colorScheme.surface,
              onIconPressed: () => Navigator.pop(context),
              icon: Icons.west_rounded,
            ),
            Text(
              'История отчетов',
              style: const AppTextStyle.text().pageTitle(),
            ),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 30),
      ],
    );
  }
}
