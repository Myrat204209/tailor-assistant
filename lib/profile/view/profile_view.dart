// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_page.dart';

class ProfileView extends HookWidget {
  const ProfileView({
    required this.employee,
    super.key,
  });

  final EmployeesItem employee;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final allOrders = state.products;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductAppBar(
              onIconClick: () => Navigator.pop(context),
              title: employee.employeeName,
            ),
            ProductSearchBar(employee: employee),
            BlocBuilder<ReportsBloc, ReportsState>(
              builder: (context, state) {
                final orders = state.orders;
                return Expanded(
                  child: ListView.builder(
                    itemCount: orders?.length ?? 0,
                    itemBuilder: (context, index) {
                      final productName = orders![index];
                      final product = allOrders.firstWhere(
                        (product) => product.itemCode == productName.key,
                      );
                      return ProductTile(
                        title: product.itemName,
                        onDeleteTap: () {
                          context
                              .read<ReportsBloc>()
                              .add(ReportOrderRemoved(employee, product));
                        },
                        colorScheme: colorScheme,
                        onEditTap: () {
                          context
                              .read<ReportsBloc>()
                              .add(ReportOperationsRequested(
                                employee: employee,
                                order: product,
                              ));
                          Navigator.of(context).push(
                            OperationPage.route(
                              order: product,
                              sewer: employee,
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
