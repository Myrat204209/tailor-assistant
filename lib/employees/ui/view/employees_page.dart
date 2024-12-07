import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:dap_foreman_assis/history/history.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:dap_foreman_assis/profile/profile.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employees_view.dart';

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<EmployeesBloc>().add(EmployeesRequested());
    return const Scaffold(
      body: EmployeesView(),
    );
  }
}
