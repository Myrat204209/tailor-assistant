import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.title,
    required this.buttonText,
    required this.onTap,
    super.key,
  });
  final String title;
  final String buttonText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      alignment: Alignment.center,
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.all(14),
      title: SizedBox(
        height: 100,
        width: 272,
        child: Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 5,
          softWrap: true,
          style: const AppTextStyle.text().pageTitle(),
        ).paddingSymmetric(horizontal: 14).centralize(),
      ),
      children: [
        SizedBox(
          width: 300,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 60,
                    child: Text(
                      'Отмена',
                      style: const AppTextStyle.text()
                          .title()
                          .withColor(AppColors.majorAccent),
                    ).centralize(),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: onTap,
                  child: SizedBox(
                    height: 60,
                    child: Text(
                      buttonText,
                      style: const AppTextStyle.text()
                          .title()
                          .withColor(AppColors.bgSecond),
                    ).centralize(),
                  ).colorize(AppColors.mainAccent).clipperOnly(15),
                ),
              ),
            ],
          ).colorize(AppColors.majorLightAccent).clipperSymmetric(15),
        ),
      ],
    ).paddingSymmetric(horizontal: 56);
  }
}
