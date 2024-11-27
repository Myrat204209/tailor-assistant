// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/excel/excel_create.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OperationView extends HookWidget {
  const OperationView({
    required this.name,
    required this.sewer,
    super.key,
  });
  final OrderItem name;
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
                  onIconPressed: () => Navigator.pop(context),
                  icon: Icons.west_rounded,
                ),
                FilledButton(
                  onPressed: () async {
                    log('Pressed Save');
                    await createAndSaveExcelFile();

                    // Handle save logic here, potentially passing
                    // state.operationValues for persistence
                  },
                  child: Text(
                    'Сохранить1',
                    style: const AppTextStyle.text().pageTitle(),
                  ).paddingSymmetric(horizontal: 20, vertical: 14),
                ),
              ],
            ).paddingSymmetric(horizontal: 20),
            Text(
              name.itemName,
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
                            (operation) =>
                                operation.toLowerCase().contains(query),
                          )
                          .map(
                            (operation) => ListTile(
                              title: Text(operation),
                              onTap: () {
                                context
                                    .read<EditCubit>()
                                    .addOperation(operation);
                                controller.closeView(operation);
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
                AppIconButton(
                  foregroundColor: AppColors.bgSecond,
                  backgroundColor: AppColors.mainAccent,
                  onIconPressed: () {
                    // Add new operation logic here if needed
                  },
                  icon: Icons.add_rounded,
                ),
              ],
            ).paddingOnly(bottom: 24),
            Expanded(
              child: ListView.builder(
                itemCount: state.selectedOperations.length,
                itemBuilder: (context, index) {
                  final operation = state.selectedOperations[index];
                  // Example field ID for each operation (can be dynamic)
                  const fieldId = 'quantity'; // Adjust based on your needs

                  // Get or create controller for this operation and fieldId
                  final controller = context
                      .read<EditCubit>()
                      .getController(operation, fieldId);

                  // Get the value saved for the operation and field
                  final fieldValue =
                      state.operationValues[operation]?[fieldId] ?? '';

                  return AppTextField(
                    colorScheme: colorScheme,
                    titleText: operation,
                    controller: controller..text = fieldValue,
                    isClose: true,
                    textFieldKey: Key('operationKey$operation$fieldId'),
                    // Save the text field value on change
                    onChanged: (value) {
                      context.read<EditCubit>().updateFieldValue(
                            operation,
                            fieldId,
                            value,
                          );
                    },
                    onRemove: () =>
                        context.read<EditCubit>().removeOperation(operation),
                    hintText: 'Введите количество',
                  );
                },
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
          ],
        );
      },
    );
  }
}
