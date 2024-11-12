// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// App Ui AppBard
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

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const AppTextStyle.text().pageTitle(),
        ).paddingOnly(left: 20, right: 5),
        Text(
          '$quantity',
          style:
              const AppTextStyle.text().description().withColor(Colors.white),
        )
            .paddingSymmetric(vertical: 5, horizontal: 14)
            .colorize(AppColors.alertAccent)
            .clipper(15),
        const Spacer(),
        AppIconButton(
          icon: firstIcon,
          foregroundColor: AppColors.majorLightAccent,
          backgroundColor: AppColors.majorAccent,
          onIconPressed: firstOnTap,
        ),
        AppIconButton(
          icon: secondIcon,
          foregroundColor: AppColors.thirdLightAccent,
          backgroundColor: AppColors.thirdAccent,
          onIconPressed: secondOnTap,
        ),
        AppIconButton(
          icon: thirdIcon,
          foregroundColor: AppColors.secondAccent,
          backgroundColor: AppColors.mainAccent,
          onIconPressed: thirdOnTap,
        ).paddingOnly(
          right: 10,
        ),
      ],
    ).paddingOnly(top: 30, bottom: 24);
  }
}
