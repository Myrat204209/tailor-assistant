import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    required this.colorScheme,
    required this.onTap,
    super.key,
  });
  final ColorScheme colorScheme;
  final VoidCallback onTap;

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
              Text(
                'Рубашка мужская',
                style: const AppTextStyle.text().contentTitle(),
              ).paddingAll(20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIconButton(
                    foregroundColor: colorScheme.error,
                    backgroundColor: colorScheme.errorContainer,
                    onIconPressed: () {},
                    icon: Icons.delete_outlined,
                  ),
                  AppIconButton(
                    foregroundColor: colorScheme.primary,
                    backgroundColor: colorScheme.primaryContainer,
                    onIconPressed: onTap,
                    icon: Icons.edit_rounded,
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(vertical: 10),
        ).colorize(Colors.white),
        const Divider(
          height: 0.1,
          color: AppColors.secondAccent,
        ),
      ],
    );
  }
}
