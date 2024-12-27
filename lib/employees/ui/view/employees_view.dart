part of 'employees_page.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeesBloc, EmployeesState>(
      builder: (context, state) {
        final employeesList = state.employees;

        return BlocListener<ReportsBloc, ReportsState>(
          listenWhen: (previous, current) =>
              previous.reports != current.reports,
          listener: (context, state) {
            if (state.reports.isNotEmpty) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(
                    'Отчеты успешно отправлены',
                    textAlign: TextAlign.center,
                    style: const AppTextStyle.text().description(),
                  ).centralize(),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: ShapeBorderX.roundedRectangle(15),
                ));
            }
          },
          child: Column(
            children: [
              EmployeeAppBar(
                quantity: employeesList.length,
              ),
              Expanded(
                child: state.status == EmployeesStatus.loading
                    ? const CircularProgressIndicator.adaptive().centralize()
                    : state.status == EmployeesStatus.success
                        ? employeesList.isEmpty
                            ? Text(
                                'Пустой в список сотрудников',
                                style: const AppTextStyle.text().pageTitle(),
                              ).centralize()
                            : ListView.builder(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.sizeOf(context).height *
                                        0.15),
                                itemCount: employeesList.length,
                                itemBuilder: (context, index) {
                                  final employee = employeesList[index];
                                  return StreamBuilder<int>(
                                    stream: context
                                        .read<ReportBoxClient>()
                                        .watchNumberOfOperations(employee),
                                    builder: (context, snapshot) {
                                      final quantity = snapshot.data ?? 0;
                                      return EmployeeTile(
                                        quantity: quantity,
                                        name: employee.employeeName,
                                        onTap: () {
                                          context
                                              .read<ReportsBloc>()
                                              .add(ReportOrdersRequested(
                                                employee: employee,
                                              ));

                                          Navigator.of(context).push(
                                            ProfilePage.route(employee),
                                          );
                                        },
                                      ).paddingSymmetric(
                                        horizontal: 20,
                                        vertical: 7,
                                      );
                                    },
                                  );
                                },
                              )
                        : Text(
                            'Ошибка в списке сотрудников',
                            style: const AppTextStyle.text().pageTitle(),
                          ).centralize(),
              ),
            ],
          ),
        );
      },
    );
  }
}
