import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReportsAppBar extends HookWidget {
  const ReportsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(useContext()).colorScheme;
    return UiAppBar(
      colorScheme: colorScheme,
      title: 'Отчеты',
      icons: [
        UiAppBarIcon(
          icon: Icons.cached_rounded,
          onTap: () {
            showAppDialog(
              context,
              'После обновления будут стёрты заполненные данные?',
              'Обновить',
              () => context.read<EmployeesBloc>().add(const EmployeesRequested()),
            );
          },
        ),
        null,
        UiAppBarIcon(
            icon: Icons.send_rounded,
            onTap: () {
              showAppDialog(
                context,
                'Отправить отчёт?',
                'Отправить',
                () {
                  //TODO: Provide with functionality
                },
              );
            })
      ],
    );
  }
}
