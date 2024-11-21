// import 'dart:developer';

import 'package:data_provider/data_provider.dart';

class OrderClient {
  OrderClient({
    required Http http,
  }) : _http = http;

  final Http _http;

  Future<List<OrderItem>?> getOrders() async {
    final response = await _http.get<List<dynamic>>('/prod_order');
    final ordersList = (response.data!).map((e) => e as JsonType).toList();
    return ordersList.map(OrderItem.fromJson).toList();
  }
}
