part of 'edit_page.dart';

class EditView extends StatelessWidget {
  const EditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppIconButton(
              foregroundColor: Colors.black,
              backgroundColor: AppColors.bgSecond,
              onIconPressed: () {
                Navigator.pop(context);
              },
              icon: Icons.west_rounded,
            ),
            FilledButton(
              onPressed: () {},
              child: Text(
                'Сохранить',
                style: const AppTextStyle.text().pageTitle(),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SearchBar(
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
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
              ).paddingOnly(left: 20, right: 14),
            ),
            AppIconButton(
              foregroundColor: AppColors.bgSecond,
              backgroundColor: AppColors.mainAccent,
              onIconPressed: () {},
              icon: Icons.add_rounded,
            ),
          ],
        ).paddingOnly(bottom: 24),
        AppTextField(
          controller: TextEditingController(),
          titleText: 'ОВ - плеч',
          hintText: 'Выведите количество',
          isClose: true,
        ),
        TextButton(
          onPressed: () {
            // showDialog(
            //   context: context,
            //   builder: (context) => AppDialog(
            //     title: 'Выйти из аккаунта?',
            //     onTap: () {},
            //     buttonText: 'Отправить',
            //   ),
            // );
          },
          child: const Text('Press me'),
        ),

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

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Рубашка мужская',
            style: const AppTextStyle.text().contentTitle(),
          ).paddingAll(20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIconButton(
                foregroundColor: AppColors.alertAccent,
                backgroundColor: AppColors.alertLightAccent,
                onIconPressed: () {},
                icon: Icons.delete_outlined,
              ),
              AppIconButton(
                foregroundColor: AppColors.majorAccent,
                backgroundColor: AppColors.majorLightAccent,
                onIconPressed: () {
                  // Navigator.of(context).push(context, route);
                },
                icon: Icons.edit_rounded,
              ),
            ],
          ),
        ],
      ).paddingSymmetric(vertical: 10),
    );
  }
}
