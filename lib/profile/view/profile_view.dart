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
    final searchController = useSearchController();
    final colorScheme = Theme.of(context).colorScheme;

    void resetSearch() {
      searchController.clear();
    }

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIconButton(
                  foregroundColor: colorScheme.onSurface,
                  backgroundColor: colorScheme.surface,
                  onIconPressed: () => Navigator.pop(context),
                  icon: Icons.west_rounded,
                ),
                Text(
                  employee.employeeName,
                  style: const AppTextStyle.text().pageTitle(),
                ),
              ],
            ).paddingSymmetric(horizontal: 20, vertical: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SearchAnchor.bar(
                    isFullScreen: false,
                    suggestionsBuilder: (context, controller) {
                      final query = controller.text.toLowerCase();
                      return state.products
                          .where(
                            (product) =>
                                product.itemName.toLowerCase().contains(query),
                          )
                          .map(
                            (product) => ListTile(
                              title: Text(product.itemName),
                              onTap: () {
                                context
                                    .read<ReportsBloc>()
                                    .add(ReportOrderAdded(employee, product));
                                controller.closeView(product.itemName);
                                resetSearch();
                              },
                            ),
                          )
                          .toList();
                    },
                    searchController: searchController,
                    barTrailing: [
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: resetSearch,
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_downward_rounded),
                        onPressed: () {
                          // Additional functionality can be added here
                        },
                      ),
                    ],
                    barElevation: const WidgetStatePropertyAll(0),
                    barShape: const WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ).paddingOnly(left: 20, right: 14),
                ),
                AppIconButton(
                  foregroundColor: colorScheme.surface,
                  backgroundColor: colorScheme.primary,
                  onIconPressed: resetSearch,
                  icon: Icons.add_rounded,
                ),
              ],
            ).paddingOnly(bottom: 24),
            BlocBuilder<ReportsBloc, ReportsState>(
              builder: (context, state) {
                final orders = state.orders;
                return Expanded(
                  child: ListView.builder(
                    itemCount: orders?.length ?? 0,
                    itemBuilder: (context, index) {
                      final productName = orders![index];
                      return ProductTile(
                        title: productName.keys.first.toString(),
                        onDeleteTap: () {
                          // context
                          //     .read<ProfileCubit>()
                          //     .removeProduct(productName);
                        },
                        colorScheme: colorScheme,
                        onEditTap: () {
                          // context.read<ReportsBloc>().add(
                          //       ReportProductSelected(product: productName),
                          // );
                          Navigator.of(context).push(
                            OperationPage.route(
                              order: productName.keys.first,
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
