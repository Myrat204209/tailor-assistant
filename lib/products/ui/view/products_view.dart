part of 'products_page.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.select((ThemeCubit cubit) => cubit.state);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        UiAppBar(
          title: 'Изделия',
          quantity: 10,
          colorScheme: colorScheme,
          firstOnTap: () {},
          secondOnTap: () {},
          thirdOnTap: () {
            context.read<ThemeCubit>().toggleTheme();
          },
          firstIcon: Icons.cached_rounded,
          secondIcon: Icons.logout_rounded,
          thirdIcon: themeCubit == ThemeMode.dark
              ? Icons.light_mode_rounded
              : Icons.dark_mode_rounded,
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => AppCard(
              orderName: 'Рубашка мужская',
              orderId: 'НФCB-000002',
              contents: contents,
              colorScheme: colorScheme,
            ),
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}

const Map<String, List<String>> contents = {
  'Цвет': ['Экру', 'Бежевый', 'Черный', 'Темно синий', 'Мышиный'],
  'Коллекция': [
    'Urban SPRING 24',
  ],
  'Вышивка': ['Atlyjam'],
  'Ткань': [
    'Poplin',
  ],
};
