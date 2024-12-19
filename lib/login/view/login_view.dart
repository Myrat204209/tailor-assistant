// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:dap_foreman_assis/login/login.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:dap_foreman_assis/settings/settings.dart';
import 'package:dap_foreman_assis/theme_selector/bloc/theme_mode_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final themeMode = context.select((ThemeModeBloc bloc) => bloc.state);
    final baseUrl = context.select((SettingsBloc bloc) => bloc.state.baseUrl);

    const labelText = 'IP адрес сервера';
    // final controller = TextEditingController();
    final baseUrlValue = baseUrl.value;
    final regExp = RegExp(r'^(?:https?:\/\/)?([^\/:]+(?:\:\d+)?)');
    final Match? match = regExp.firstMatch(baseUrlValue);

    final initialValue = match != null ? match.group(1)! : '';

    return Scaffold(
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onLongPress: () => {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                      content: Text('Вы включили режим разработчика'))),
                showTextFieldDialog(
                  context: context,
                  onSuccess: (value) async {
                    context
                        .read<SettingsBloc>()
                        .add(SettingsBaseUrlChanged('http://$value'));
                  },
                  validator: (value) =>
                      switch (baseUrl.validator(value ?? '')) {
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
                )
              },
              child: AppIconButton(
                foregroundColor: AppColors.secondAccent,
                backgroundColor: AppColors.mainAccent,
                onIconPressed: () =>
                    context.read<ThemeModeBloc>().add(const ThemeModeChanged()),
                icon: themeMode == ThemeMode.dark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
              ).paddingOnly(right: 10, top: 30),
            ),
          ),
          SizedBox.square(
            dimension: height * 0.35,
            child: Image.asset(
              'assets/auth.png',
              fit: BoxFit.contain,
            ).paddingOnly(right: 45, left: 67),
          ),
          // const Expanded(child: LoginForm()),
          const LoginForm(),
        ],
      ),
    );
  }
}
