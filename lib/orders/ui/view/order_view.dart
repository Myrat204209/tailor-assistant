part of 'orders_page.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.select((ThemeCubit cubit) => cubit.state);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        return Column(
          children: [
            UiAppBar(
              title: 'Изделия',
              quantity: state.orders == null ? 0 : state.orders!.length,
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
                itemCount: state.orders!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final order = state.orders![index];
                  return AppCard(
                    startOrder: order.startOrder,
                    quantity: order.orderQuantity!,
                    orderName: order.orderName!,
                    orderId: order.orderId!,
                    contents: {
                      'Цвет': order.orderColors,
                      'Коллекция': order.orderCollection ?? [],
                      'Вышивка': order.orderVyshyvka ?? [],
                      'Ткань': order.orderTextile,
                      'Принт': order.orderPrint ?? [],
                    },
                    colorScheme: colorScheme,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

const Map<String, List<String>> contents = {};
