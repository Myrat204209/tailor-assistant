// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OperationView extends HookWidget {
  const OperationView({
    required this.orderItem,
    required this.sewer,
    super.key,
  });
  final OrderItem orderItem;
  final EmployeesItem sewer;

  @override
  Widget build(BuildContext context) {
    final searchController = useSearchController();
    final colorScheme = Theme.of(context).colorScheme;

    void resetSearch() {
      searchController.clear();
    }

    return BlocBuilder<EditCubit, EditState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIconButton(
                  foregroundColor: colorScheme.onSurface,
                  backgroundColor: colorScheme.surface,
                  onIconPressed: () {
                    context
                        .read<ReportsBloc>()
                        .add(ReportOrdersRequested(employee: sewer));
                    Navigator.pop(context);
                  },
                  icon: Icons.west_rounded,
                ),
                FilledButton(
                  onPressed: () async {},
                  child: Text(
                    'Сохранить',
                    style: const AppTextStyle.text().pageTitle(),
                  ).paddingSymmetric(horizontal: 20, vertical: 14),
                ),
              ],
            ).paddingSymmetric(horizontal: 20),
            Text(
              orderItem.itemName,
              softWrap: true,
              style: const AppTextStyle.text().pageTitle(),
            ).paddingSymmetric(horizontal: 20, vertical: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SearchAnchor.bar(
                    isFullScreen: false,
                    suggestionsBuilder: (context, controller) {
                      final query = controller.text.toLowerCase();
                      return state.operations
                          .where(
                            (operation) => operation.workName
                                .toLowerCase()
                                .contains(query),
                          )
                          .map(
                            (operation) => ListTile(
                              title: Text(operation.workName),
                              onTap: () {
                                context.read<ReportsBloc>().add(
                                      ReportOperationAdded(
                                        employee: sewer,
                                        order: orderItem,
                                        operation: operation,
                                        quantity: 0,
                                      ),
                                    );
                                controller.closeView(operation.workName);
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
                        onPressed: searchController.clear,
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_downward_rounded),
                        onPressed: searchController.openView,
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
              ],
            ).paddingOnly(bottom: 24),
            BlocBuilder<ReportsBloc, ReportsState>(
              builder: (context, state) {
                final blocOperations = state.operations;
                return Expanded(
                  child: ListView.builder(
                    itemCount: blocOperations?.length ?? 0,
                    itemBuilder: (context, index) {
                      final workCode = blocOperations?[index].key;
                      final controller = TextEditingController();
                      final operation = context
                          .read<EditCubit>()
                          .findOperationByWorkCode(workCode!);
                      return AppTextField(
                        colorScheme: colorScheme,
                        titleText: operation!.workName,
                        onSubmitted: (quantity) {
                          context.read<ReportsBloc>().add(ReportOperationAdded(
                              employee: sewer,
                              order: orderItem,
                              operation: operation,
                              quantity: int.parse(controller.text)));
                        },
                        controller: controller,
                        isClose: true,
                        // textFieldKey: Key('operationKey$operation$'),
                        onChanged: (value) {},
                        onRemove: () => () {},
                        hintText: 'Введите количество',
                      );
                    },
                  ),
                );
              },
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
          ],
        );
      },
    );
  }
}
