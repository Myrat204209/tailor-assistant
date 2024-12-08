// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:dap_foreman_assis/history/history.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EmployeeAppBar extends HookWidget {
  const EmployeeAppBar({
    required this.quantity,
    super.key,
  });

  final int quantity;
  @override
  Widget build(BuildContext context) {
    final employeesList =
        context.select((EmployeesBloc bloc) => bloc.state.employees);
    final orders = context.select((OrdersBloc bloc) => bloc.state.orders);
    final operations =
        context.select((OperationBloc bloc) => bloc.state.operations);
    final colorScheme = Theme.of(useContext()).colorScheme;
    return UiAppBar(
      colorScheme: colorScheme,
      title: 'Швеи',
      quantity: quantity,
      icons: [
        UiAppBarIcon(
          icon: Icons.cached_rounded,
          onTap: () {
            showAppDialog(
              context,
              'После обновления будут стёрты заполненные данные?',
              'Обновить',
              () {
                context.read<EmployeesBloc>().add(EmployeesRequested());
                Navigator.pop(context);
              },
            );
          },
        ),
        UiAppBarIcon(
          icon: Icons.history_rounded,
          onTap: () => Navigator.of(context).push(HistoryPage.route()),
        ),
        UiAppBarIcon(
            icon: Icons.send_rounded,
            onTap: () {
              showAppDialog(
                context,
                'Отправить отчёт?',
                'Отправить',
                () {
                  context.read<ReportsBloc>().add(ReportsSendRequested(
                        employeesFull: employeesList,
                        ordersFull: orders,
                        operationsFull: operations,
                      ));
                  Navigator.pop(context);
                },
              );
            }),
      ],
    );
  }
}
