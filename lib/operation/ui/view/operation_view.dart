// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OperationView extends HookWidget {
  const OperationView({
    required this.name,
    super.key,
  });
  final String name;

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
                  onPressed: () {
                    // Handle save logic here
                  },
                  child: Text(
                    'Сохранить',
                    style: const AppTextStyle.text().pageTitle(),
                  ).paddingSymmetric(horizontal: 20, vertical: 14),
                ),
              ],
            ).paddingSymmetric(
              horizontal: 20,
            ),
            Text(
              name,
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
                    // Add new operation logic here
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
final controller = context.read<EditCubit>().getController(operation);
                  return AppTextField(
                    colorScheme: colorScheme,
                    titleText: operation,
                    controller: controller,
                    isClose: true,
                    textFieldKey: Key('operationKey$operation'),
                    onChanged: (value) {},
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
