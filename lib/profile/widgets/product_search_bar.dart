// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/profile/profile.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProductSearchBar extends HookWidget {
  const ProductSearchBar({
    required this.employee,
    super.key,
  });

  final EmployeesItem employee;
  @override
  Widget build(BuildContext context) {
    final allOrders =
        context.select((ProfileCubit cubit) => cubit.state.products);
    final searchController = useSearchController();

    void resetSearch() {
      searchController.clear();
    }
<<<<<<< HEAD
=======

    final colorScheme = Theme.of(useContext()).colorScheme;
>>>>>>> ba368eea2927bffb3f52d4532bf3f98668e156b5

    final colorScheme = Theme.of(useContext()).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SearchAnchor.bar(
            isFullScreen: false,
            suggestionsBuilder: (context, controller) {
              final query = controller.text.toLowerCase();
              return allOrders
                  .where((product) =>
                      product.itemName.toLowerCase().contains(query))
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
                      trailing: Text(
                        product.docNumber,
                        style: const AppTextStyle.text()
                            .description()
                            .withColor(colorScheme.primary),
                      ),
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
        // AppIconButton(
        //   foregroundColor: colorScheme.surface,
        //   backgroundColor: colorScheme.primary,
        //   onIconPressed: resetSearch,
        //   icon: Icons.add_rounded,
        // ),
      ],
    ).paddingOnly(bottom: 24);
  }
}
