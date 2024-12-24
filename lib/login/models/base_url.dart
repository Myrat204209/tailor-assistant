import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:dap_foreman_assis/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppUtils {
  AppUtils();

  static void showBaseUrlDialog({required BuildContext context}) {
    final baseUrl = context.read<SettingsBloc>().state.baseUrl;

    const labelText = 'IP адрес сервера';
    final baseUrlValue = baseUrl.value;
    final regExp = RegExp(r'^(?:https?:\/\/)?([^\/:]+(?:\:\d+)?)');
    final Match? match = regExp.firstMatch(baseUrlValue);

    final initialValue = match != null ? match.group(1)! : '';
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Вы включили режим разработчика',
            textAlign: TextAlign.center,
            style: const AppTextStyle.text().title(),
          ).centralize(),
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: ShapeBorderX.roundedRectangle(15),
        ),
      );
    showTextFieldDialog(
      context: context,
      onSuccess: (value) async {
        context
            .read<SettingsBloc>()
            .add(SettingsBaseUrlChanged('http://$value'));
      },
      validator: (value) => switch (baseUrl.validator(value ?? '')) {
        BaseUrlValidationError.empty => 'Запольните поле',
        BaseUrlValidationError.invalid => 'Не правильный IP адрес',
        _ => null,
      },
      initialValue: initialValue,
      labelText: labelText,
    ).whenComplete(
      () {
        context
          ..read<EmployeesBloc>().add(const EmployeesRequested())
          ..read<OperationBloc>().add(const OperationRequested())
          ..read<OrdersBloc>().add(const OrdersRequested());
      },
    );
  }
}
