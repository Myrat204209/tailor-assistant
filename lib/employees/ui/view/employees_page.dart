import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:dap_foreman_assis/product/product.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employees_view.dart';

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EmployeesView(),
    );
  }
}
