part of 'employees_page.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeesBloc, EmployeesState>(
      buildWhen: (previous, current) =>
          previous.employees.length != current.employees.length,
      builder: (context, state) {
        final employeesList = state.employees;
        return BlocListener<ReportsBloc, ReportsState>(
          listenWhen: (previous, current) =>
              previous.reports != current.reports,
          listener: (context, state) {
            if (state.reports.isNotEmpty) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      'Отчеты успешно отправлены',
                      style: const AppTextStyle.text().description(),
                    ),
                  ),
                );
            }
          },
          child: Column(
            children: [
              EmployeeAppBar(
                quantity: employeesList.length,
              ),
              Expanded(
                child: employeesList.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.builder(
                        itemCount: employeesList.length,
                        itemBuilder: (context, index) {
                          final employee = employeesList[index];
                          return EmployeeTile(
                            name: employee.employeeName,
                            onTap: () {
                              context.read<ReportsBloc>().add(
                                  ReportOrdersRequested(employee: employee));

                              Navigator.of(context).push(
                                ProfilePage.route(employee),
                              );
                            },
                          ).paddingSymmetric(horizontal: 20, vertical: 7);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
