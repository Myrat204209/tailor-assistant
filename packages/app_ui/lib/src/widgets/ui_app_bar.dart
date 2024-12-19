// ignore_for_file:  sort_constructors_first, lines_longer_than_80_chars
// ignore_for_file: public_member_api_docs

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class UiAppBarIcon {
  UiAppBarIcon({required this.icon, required this.onTap,this.onLongPress});

  final IconData icon;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
}


class UiAppBar extends StatelessWidget {
  /// Constructor
  const UiAppBar({
    required this.title,
    required this.icons,
    required this.colorScheme,
    
    super.key,
    this.quantity,
  });

  final int? quantity;
  final String title;
  final List<UiAppBarIcon?> icons;

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final colorMap = [
      {
        'bC': colorScheme.secondary,
        'fC': colorScheme.onSecondary,
      },
      {
        'bC': colorScheme.tertiary,
        'fC': colorScheme.onTertiary,
      },
      {
        'bC': colorScheme.primary,
        'fC': colorScheme.onPrimary,
      },
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const AppTextStyle.text()
              .pageTitle()
              .withColor(colorScheme.onSurface), // Use onSurface for title
        ).paddingOnly(left: 20, right: 5),
        if (quantity != null)
          Text(
            '$quantity',
            style:
                const AppTextStyle.text().description().withColor(Colors.white),
          )
              .paddingSymmetric(vertical: 5, horizontal: 14)
              .colorize(colorScheme.onError)
              .clipper(15),
        const Spacer(),
        ...icons.map((icon) {
          if (icon == null) return const SizedBox.shrink();
          return AppIconButton(
            icon: icon.icon,
            onLongPressed: icon.onLongPress,
            foregroundColor: colorMap[icons.indexOf(icon)]['fC']!,
            backgroundColor: colorMap[icons.indexOf(icon)]['bC']!,
            onIconPressed: icon.onTap,
          );
        }),
        const Padding(padding: EdgeInsets.only(right: 10)),
      ],
    ).paddingOnly(top: 30, bottom: 24);
  }
}
