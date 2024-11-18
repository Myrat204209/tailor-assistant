part of 'sewers_page.dart';

class SewersView extends StatelessWidget {
  const SewersView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
          colorScheme: colorScheme,
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SewerTile(
                name: 'Оразгуль',
                onTap: () {
                  Navigator.of(context).push(ProfilePage.route());
                },
              ).paddingSymmetric(horizontal: 20, vertical: 7);
            },
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
