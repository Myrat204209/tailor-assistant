// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

Future<void> showAppDialog(
  BuildContext dialogContext,
  String message,
  String buttonText,
  VoidCallback onTap,
) async {
  await showDialog<AppDialog>(
    context: dialogContext,
    builder: (_) => AppDialog(
      title: message,
      buttonText: buttonText,
      onTap: onTap,
    ),
  );
}

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
    final colorScheme = Theme.of(context).colorScheme;
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
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                    height: 60,
                    child: Text(
                      'Отмена',
                      style: const AppTextStyle.text()
                          .title()
                          .withColor(colorScheme.secondary),
                    ).centralize(),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    onTap.call();
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 60,
                    child: Text(
                      buttonText,
                      style: const AppTextStyle.text()
                          .title()
                          .withColor(colorScheme.surface),
                    ).centralize(),
                  ).colorize(colorScheme.primary).clipperOnly(15),
                ),
              ),
            ],
          ).colorize(colorScheme.onSecondary).clipperSymmetric(15),
        ),
      ],
    ).paddingSymmetric(horizontal: 56);
  }
}
