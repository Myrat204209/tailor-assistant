import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:dap_foreman_assis/profile/profile.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final employeesList =
        context.select((EmployeesBloc bloc) => bloc.state.employees);
    return Column(
      children: [
        const ReportsAppBar(),
        const ReportsDateTab(),
        BlocBuilder<ReportsNetworkBloc, ReportsNetworkState>(
          builder: (context, state) {
            final reportsList = state.reports;
            return Expanded(
              child: employeesList.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      itemCount: employeesList.length,
                      itemBuilder: (context, index) {
                        return ReportTile(
                          reportsCount: state.getReportCount(
                              employeesList[index].employeeCode),
                          name: employeesList[index].employeeName,
                          onTap: () {
                            Navigator.of(context).push(
                              ProfilePage.route(employeesList[index]),
                            );
                          },
                        ).paddingSymmetric(horizontal: 20, vertical: 7);
                      },
                    ),
            );
          },
        ),
      ],
    );
  }
}
