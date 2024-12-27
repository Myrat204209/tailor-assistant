import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OperationSearchBar extends HookWidget {
  const OperationSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final allOperations =
        context.select((OperationBloc bloc) => bloc.state.operations);
    final isLoading = context.select(
        (OperationBloc bloc) => bloc.state.status == OperationStatus.loading);
    final searchController = useSearchController();
    void resetSearch() {
      searchController.clear();
    }

    // final colorScheme = Theme.of(useContext()).colorScheme;
    return isLoading
        ? const CircularProgressIndicator.adaptive().centralize()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SearchAnchor.bar(
                  isFullScreen: false,
                  suggestionsBuilder: (context, controller) {
                    final query = controller.text.toLowerCase();
                    return allOperations
                        .where(
                          (operation) =>
                              operation.workName.toLowerCase().contains(query),
                        )
                        .map(
                          (operation) => ListTile(
                            title: Text(operation.workName),
                            onTap: () {
                              context.read<EditCubit>().addOperation(operation);
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
                      icon: const Icon(Icons.keyboard_arrow_down),
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
          ).paddingOnly(bottom: 24);
  }
}
