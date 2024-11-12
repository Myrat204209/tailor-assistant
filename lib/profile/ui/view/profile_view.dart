part of 'profile_page.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

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
            Text(
              'Оразгуль',
              style: const AppTextStyle.text().pageTitle(),
            ),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // Add more decoration..
                ),
                hint: Text(
                  'Список изделий',
                  style: const AppTextStyle.text()
                      .title()
                      .withColor(AppColors.textColor),
                ),
                items: genderItems
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const AppTextStyle.text()
                              .title()
                              .withColor(AppColors.textColor),
                        ),
                      ),
                    )
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                  return null;
                },
                onChanged: (value) {
                  //Do something when selected item is changed.
                },
                onSaved: (value) {},
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 16),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 25,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
        const AppListTile().colorize(Colors.white),
        const Divider(
          height: 0.1,
          color: AppColors.secondAccent,
        ),
        const AppListTile().colorize(Colors.white),
        const Divider(
          height: 0.1,
          color: AppColors.secondAccent,
        ),
        const AppListTile().colorize(Colors.white),
        const Divider(
          height: 0.1,
          color: AppColors.secondAccent,
        ),
      ],
    );
  }
}

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
                  Navigator.of(context).push(EditPage.route());
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

final List<String> genderItems = [
  'Male',
  'Female',
];
