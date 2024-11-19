part of 'employees_page.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key});

  @override
  Widget build(BuildContext context) {
    final employeesList =
        context.select((EmployeesBloc bloc) => bloc.state.employees);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<EmployeesBloc, EmployeesState>(
      buildWhen: (previous, current) =>
          previous.employees.length != current.employees.length,
      builder: (context, state) {
        return Column(
          children: [
            UiAppBar(
              title: 'Швеи',
              quantity: employeesList.length,
              firstIcon: Icons.cached_rounded,
              secondIcon: Icons.history_rounded,
              thirdIcon: Icons.send_rounded,
              firstOnTap: () {},
              secondOnTap: () {},
              thirdOnTap: () {},
              colorScheme: colorScheme,
            ),
            Expanded(
              child: employeesList.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      itemCount: employeesList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SewerTile(
                          name: employeesList.elementAt(index).employeeName,
                          onTap: () {
                            Navigator.of(context).push(ProfilePage.route());
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
