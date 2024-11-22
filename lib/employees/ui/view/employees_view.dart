part of 'employees_page.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key});

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
                                employeesList.elementAt(index).employeeName,
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
