import 'package:dap_foreman_assis/login/login.dart';
import 'package:dap_foreman_assis/settings/bloc/settings_bloc.dart';
import 'package:dap_foreman_assis/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseUrlField extends StatelessWidget {
  const BaseUrlField({super.key});

  @override
  Widget build(BuildContext context) {
    final baseUrl = context.select((SettingsBloc bloc) => bloc.state.baseUrl);

    const labelText = 'IP адрес сервера';

    return ListTile(
      onTap: () {
        showTextFieldDialog(
          context: context,
          onSuccess: (value) async {
            context.read<SettingsBloc>().add(SettingsBaseUrlChanged(value));
          },
          validator: (value) => switch (baseUrl.validator(value ?? '')) {
            BaseUrlValidationError.empty => 'empty',
            BaseUrlValidationError.invalid => 'url_is_not_valid',
            _ => null,
          },
          initialValue: baseUrl.value,
          labelText: labelText,
        );
      },
      title: const Text(labelText),
      subtitle: Text(baseUrl.value),
    );
  }
}
