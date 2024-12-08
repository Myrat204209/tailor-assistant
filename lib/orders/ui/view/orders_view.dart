part of 'orders_page.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        return Column(
          children: [
            OrdersAppBar(quantity: state.orders.length),
            
            if (state.status == OrdersStatus.loading)
              const Align(
                child: Center(child: CircularProgressIndicator.adaptive()),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: state.orders.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final order = state.orders[index];
                    return AppCard(
                      startOrder: order.startOrder,
                      quantity: order.quantity.toInt(),
                      orderName: order.itemName,
                      orderId: order.docNumber,
                      contents: {
                        'Цвет': order.attrColor
                          ..removeWhere((element) => element == ''),
                        'Коллекция': [order.attrCollection]
                          ..removeWhere((element) => element == ''),
                        'Вышивка': order.attrVyshyvka
                          ..removeWhere((element) => element == ''),
                        'Ткань': order.attrTextile
                          ..removeWhere((element) => element == ''),
                        'Принт': order.attrPrint
                          ..removeWhere((element) => element == ''),
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
