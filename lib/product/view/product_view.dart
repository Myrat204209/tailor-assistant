// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_page.dart';

class ProfileView extends HookWidget {
  const ProfileView({
    required this.employee,
    super.key,
  });

  final EmployeesItem employee;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProfileState>(
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
            Expanded(
              child: ProductContent(
                allOrders: allOrders,
                employee: employee,
              ),
            ),
          ],
        );
      },
    );
  }
}
