import 'package:data_provider/data_provider.dart';

class OrderClient {
  const OrderClient({
    required Http httpClient,
  }) : _http = httpClient;

  final Http _http;

  Future<List<OrderItem>?> getOrders() async {
    try {
      final response = await _http.get<List<dynamic>>('/prod_order');

      final ordersList = response.data!.map((e) => e as JsonType).toList();
      return ordersList.map(OrderItem.fromJson).toList();
    } 
    // on DioException catch (_) {
    //   final orders = await getJsonList(
    //     'packages/data_provider/assets/local_orders.json',
    //   );
    //   if (orders != null) {
    //     return orders
    //         .map((e) => e as JsonType)
    //         .toList()
    //         .map(OrderItem.fromJson)
    //         .toList();
    //   } else {
    //     throw Exception('Failed to load local orders data.');
    //   }
    // } 
    catch (error) {
      throw Exception('Error fetching orders: $error');
    }
  }
}
