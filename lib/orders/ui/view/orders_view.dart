part of 'orders_page.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.select((ThemeCubit cubit) => cubit.state);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state.status == OrdersStatus.loading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return Column(
          children: [
            UiAppBar(
              title: 'Изделия',
              quantity: state.orders == null ? 0 : state.orders!.length,
              colorScheme: colorScheme,
              firstOnTap: () {
                showAppDialog(
                  context,
                  'После обновления будут стёрты заполненные данные?',
                  'Обновить',
                  () {
                    context.read<OrdersBloc>().add(const OrdersRequested());
                    Navigator.pop(context);
                  },
                );
              },
              secondOnTap: () {
                showAppDialog(context, 'Выйти из аккаунта?', 'Выход', () {
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                  // Navigator.of(context)
                  //     .popUntil((route) => route.settings.name == '/login');
                });
              },
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
                    startOrder: order.startOrder!,
                    quantity: order.quantity.toInt(),
                    orderName: order.itemName,
                    orderId: order.docNumber!,
                    contents: {
                      'Цвет': order.attrColor,
                      'Коллекция': [order.attrCollection],
                      'Вышивка': order.attrVyshyvka,
                      'Ткань': order.attrTextile,
                      'Принт': order.attrPrint,
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
