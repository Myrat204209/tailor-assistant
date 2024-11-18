import 'package:data_provider/data_provider.dart';

class OrderClient {
  OrderClient({
    required Http http,
  }) : _http = http;

  final Http _http;

  Future<List<OrderItem>?> getOrders() async {
    final response = await _http.get<List<JsonType>>('/prod_order');

    return response.data!.map(OrderItem.fromJson).toList();
  }
}
