part of 'profile_page.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

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
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // Add more decoration..
                ),
                hint: Text(
                  'Список изделий',
                  style: const AppTextStyle.text()
                      .title()
                      .withColor(colorScheme.onSurface),
                ),
                items: genderItems
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const AppTextStyle.text()
                              .title()
                              .withColor(colorScheme.onSurface),
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
              foregroundColor: colorScheme.surface,
              backgroundColor: colorScheme.primary,
              onIconPressed: () {},
              icon: Icons.add_rounded,
            ),
          ],
        ).paddingOnly(bottom: 24),
        ProductTile(
          onDeleteTap: () {},
          colorScheme: colorScheme,
          onEditTap: () {
            Navigator.of(context).push(EditPage.route());
          },
        ),
      ],
    );
  }
}

final List<String> genderItems = [
  'Male',
  'Female',
];
