import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

Future<void> showTextFieldDialog({
  required BuildContext context,
  void Function(String value)? onSuccess,
  String? initialValue,
  String? labelText,
  String? Function(String?)? validator,
}) async {
  final errorText = ValueNotifier<String?>(null);
  final colorScheme = Theme.of(context).colorScheme;
  final formKey = GlobalKey<FormState>();
  var value = initialValue ?? '';
  void checkConfirmAvailability(String? v, [isFirstTime = false]) {
    if (validator != null) {
      errorText.value = validator(v);
    }
  }

  checkConfirmAvailability(initialValue);

  await showAdaptiveDialog<String>(
    context: context,
    builder: (context) => SimpleDialog(
      alignment: Alignment.center,
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
      title: Row(
        children: [
          Expanded(
            child: Form(
              key: formKey,
              child: ValueListenableBuilder(
                valueListenable: errorText,
                builder: (context, error, _) {
                  return TextFormField(
                    autofocus: true,
                    onChanged: (v) {
                      value = v;
                      checkConfirmAvailability(v);
                    },
                    initialValue: initialValue,
                    validator: validator,
                    decoration: InputDecoration(
                      labelText: labelText,
                      prefixText: '  http://',
                      errorText: error,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      children: [
        Row(
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
                  if (formKey.currentState!.validate()) {
                    onSuccess?.call(value);
                  }
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 60,
                  child: Text(
                    'ОК',
                    style: const AppTextStyle.text()
                        .title()
                        .withColor(colorScheme.surface),
                  ).centralize(),
                ).colorize(colorScheme.primary).clipperOnly(15),
              ),
            ),
          ],
        ).colorize(colorScheme.onSecondary).clipperSymmetric(15),
      ],
    ),
  );
}
