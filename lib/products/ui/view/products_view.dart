part of 'products_page.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          UiAppBar(
            title: 'Изделия',
            quantity: 10,
            firstOnTap: () {},
            secondOnTap: () {},
            thirdOnTap: () {},
            firstIcon: Icons.cached_rounded,
            secondIcon: Icons.logout_rounded,
            thirdIcon: Icons.dark_mode_rounded,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => const AppCard(
                orderName: 'Рубашка мужская',
                orderId: 'НФCB-000002',
                contents: contents,
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
