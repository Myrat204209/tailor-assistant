part of 'sewers_page.dart';

class SewersView extends StatelessWidget {
  const SewersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UiAppBar(
          title: 'Швеи',
          quantity: 10,
          firstIcon: Icons.cached_rounded,
          secondIcon: Icons.history_rounded,
          thirdIcon: Icons.send_rounded,
          firstOnTap: () {},
          secondOnTap: () {},
          thirdOnTap: () {},
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: Colors.white,
                title: Text(
                  'Оразгуль',
                  style: const AppTextStyle.text().contentTitle(),
                ).paddingSymmetric(vertical: 16, horizontal: 14),
                trailing: IconButton.filled(
                  onPressed: () {
                    Navigator.of(context).push(ProfilePage.route());
                  },
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    foregroundColor: AppColors.thirdAccent,
                    backgroundColor: AppColors.thirdLightAccent,
                  ),
                  icon: const Icon(Icons.east_sharp, size: 35)
                      .paddingAll(12)
                      .paddingOnly(bottom: 5),
                ).paddingOnly(right: 14),
                contentPadding: EdgeInsets.zero,
                shape: ShapeBorderX.roundedRectangle(15),
              ).paddingSymmetric(horizontal: 20, vertical: 7);
            },
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
