import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// App Ui AppBar
class UiAppBar extends StatelessWidget {
  /// Constructor
  const UiAppBar({
    required this.title,
    required this.quantity,
    required this.firstOnTap,
    required this.firstIcon,
    required this.secondOnTap,
    required this.secondIcon,
    required this.thirdOnTap,
    required this.thirdIcon,
    required this.colorScheme, // Pass the entire ColorScheme
    super.key,
  });

  final String title;
  final int quantity;
  final VoidCallback firstOnTap;
  final IconData firstIcon;
  final VoidCallback secondOnTap;
  final IconData secondIcon;
  final VoidCallback thirdOnTap;
  final IconData thirdIcon;

  /// The active theme's ColorScheme
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const AppTextStyle.text()
              .pageTitle()
              .withColor(colorScheme.onSurface), // Use onSurface for title
        ).paddingOnly(left: 20, right: 5),
        Text(
          '$quantity',
          style: const AppTextStyle.text().description().withColor(
                Colors.white,
              ),
        )
            .paddingSymmetric(vertical: 5, horizontal: 14)
            .colorize(
              colorScheme.onError,
            )
            .clipper(15),
        const Spacer(),
        AppIconButton(
          icon: firstIcon,
          foregroundColor: colorScheme.onSecondary,
          backgroundColor: colorScheme.secondary,
          onIconPressed: firstOnTap,
        ),
        AppIconButton(
          icon: secondIcon,
          foregroundColor: colorScheme.onTertiary,
          backgroundColor: colorScheme.tertiary,
          onIconPressed: secondOnTap,
        ),
        AppIconButton(
          icon: thirdIcon,
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          onIconPressed: thirdOnTap,
        ).paddingOnly(
          right: 10,
        ),
      ],
    ).paddingOnly(top: 30, bottom: 24);
  }
}
