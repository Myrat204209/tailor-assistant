part of 'employees_page.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.select((OrdersBloc bloc) => bloc.state.orders);
    final operations =
        context.select((OperationBloc bloc) => bloc.state.operations);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<EmployeesBloc, EmployeesState>(
      buildWhen: (previous, current) =>
          previous.employees.length != current.employees.length,
      builder: (context, state) {
        final employeesList = state.employees;
        return Column(
          children: [
            UiAppBar(
              title: 'Швеи',
              quantity: employeesList.length,
              firstIcon: Icons.cached_rounded,
              secondIcon: Icons.history_rounded,
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
              secondOnTap: () {
                Navigator.of(context).push(HistoryPage.route());
              },
              thirdOnTap: () {
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
              },
              colorScheme: colorScheme,
            ),
            Expanded(
              child: employeesList.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      itemCount: employeesList.length,
                      itemBuilder: (context, index) {
                        final employee = employeesList[index];
                        return SewerTile(
                          name: employee.employeeName,
                          onTap: () {
                            context
                                .read<ReportsBloc>()
                                .add(ReportOrdersRequested(employee: employee));

                            Navigator.of(context).push(
                              ProfilePage.route(employee),
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
