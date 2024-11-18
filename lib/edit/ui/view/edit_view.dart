part of 'edit_page.dart';

class EditView extends StatelessWidget {
  const EditView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
              onPressed: () {},
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
              child: SearchBar(
                backgroundColor: WidgetStatePropertyAll(colorScheme.surface),
                trailing: [
                  const Icon(Icons.close_rounded).paddingOnly(right: 10),
                  const Icon(Icons.arrow_downward_rounded),
                ],
                elevation: const WidgetStatePropertyAll(0),
                shape: const WidgetStatePropertyAll(
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
              onIconPressed: () {},
              icon: Icons.add_rounded,
            ),
          ],
        ).paddingOnly(bottom: 24),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 7,
            itemBuilder: (context, index) {
              return AppTextField(
                colorScheme: Theme.of(context).colorScheme,
                controller: TextEditingController(),
                titleText: 'ОВ - плеч',
                hintText: 'Выведите количество',
                isClose: true,
              );
            },
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 20)),

        // AppTextField(
        //   controller: TextEditingController(),
        //   titleText: 'Распошивание рукавов',
        //   hintText: '52',
        //   isClose: true,
        // ),
        // AppTextField(
        //   controller: TextEditingController(),
        //   titleText: 'ПС - пришивание киперки',
        //   hintText: '150',
        //   isClose: true,
        // ),
      ],
    );
  }
}

final List<String> genderItems = [
  'Male',
  'Female',
  'Female1',
  'Female2',
  'Female3',
  'Female4',
  'Female5',
];
