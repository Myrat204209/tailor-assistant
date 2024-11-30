import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:dap_foreman_assis/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<EmployeesBloc, EmployeesState>(
      buildWhen: (previous, current) =>
          previous.employees.length != current.employees.length,
      builder: (context, state) {
        final employeesList = state.employees;
        return Column(
          children: [
            UiAppBar(
              title: 'Отчеты',
              quantity: null,
              firstIcon: Icons.cached_rounded,
              secondIcon: null,
              thirdIcon: Icons.send_rounded,
              firstOnTap: () {
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
              secondOnTap: () {},
              thirdOnTap: () {
                showAppDialog(
                  context,
                  'Отправить отчёт?',
                  'Отправить',
                  () {
                    //TODO: Provide with functionality
                  },
                );
              },
              colorScheme: colorScheme,
            ),
            Expanded(
              child: employeesList.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      itemCount: employeesList.length,
                      itemBuilder: (context, index) {
                        return SewerTile(
                          name: employeesList.elementAt(index).employeeName,
                          onTap: () {
                            Navigator.of(context).push(
                              ProfilePage.route(
                                employeesList.elementAt(index),
                              ),
                            );
                          },
                        ).paddingSymmetric(horizontal: 20, vertical: 7);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
