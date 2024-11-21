part of 'operation_page.dart';

class EditView extends HookWidget {
  const EditView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useSearchController();
    final colorScheme = Theme.of(context).colorScheme;
    final operationsList =
        context.select((OperationBloc bloc) => bloc.state.operations);
    final filteredList = useState<List<OperationItem>>(operationsList);

    void handleSearch(String query) {
      if (query.isEmpty) {
        filteredList.value = operationsList;
      } else {
        filteredList.value = operationsList
            .where(
              (operation) => operation.workName
                  .toLowerCase()
                  .contains(query.toLowerCase()),
            )
            .toList();
      }
    }

    void resetSearch() {
      searchController.clear();
      filteredList.value = operationsList;
    }

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
        ).paddingSymmetric(horizontal: 20, vertical: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SearchAnchor.bar(
                isFullScreen: false,
                suggestionsBuilder: (context, controller) {
                  return [];
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
                onChanged: handleSearch,
                barElevation: const WidgetStatePropertyAll(0),
                barShape: const WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ).paddingOnly(
                left: 20,
                right: 14,
              ),
            ),
            AppIconButton(
              foregroundColor: AppColors.bgSecond,
              backgroundColor: AppColors.mainAccent,
              onIconPressed: resetSearch, // Reset search and show all items
              icon: Icons.add_rounded,
            ),
          ],
        ).paddingOnly(bottom: 24),
        Expanded(
          child: ListView.builder(
            itemCount: filteredList.value.length,
            itemBuilder: (context, index) {
              final operation = filteredList.value[index];
              return ListTile(
                title: Text(operation.workName),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
                ),
              );
            },
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 20)),
      ],
    );
  }
}
