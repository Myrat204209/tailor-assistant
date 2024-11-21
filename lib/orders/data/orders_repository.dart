import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

/// A base failure for the product repository failures
abstract class OrdersFailure with EquatableMixin implements Exception {
  const OrdersFailure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}

class GetOrdersListFailure extends OrdersFailure {
  const GetOrdersListFailure(super.error);
}

class OrdersRepository {
  const OrdersRepository({
    required OrderClient orderClient,
  }) : _orderClient = orderClient;

  final OrderClient _orderClient;

  /// Remote method to get and group orders.
  Future<List<OrdersModel>> getOrders() async {
    try {
      // Fetch raw order items from the client
      final orderItems = await _orderClient.getOrders();

      // Grouping logic for OrdersModel
      final groupedOrders = <String, OrdersModel>{};

      for (final order in orderItems!) {
        final docNumber = order.docNumber ?? 'Unknown';
        final startOrder = order.startOrder ?? 'Unknown';
        for (final product in order.items ?? []) {
          if (product == null) continue;
          product as ProductItem;
          if (groupedOrders.containsKey(docNumber)) {
            // Update existing grouped order
            final existingOrder = groupedOrders[docNumber]!;

            groupedOrders[docNumber] = OrdersModel(
              startOrder: startOrder,
              orderId: existingOrder.orderId,
              orderName: existingOrder.orderName,
              orderQuantity:
                  existingOrder.orderQuantity! + product.quantity.toInt(),
              orderColors: {
                ...existingOrder.orderColors,
                product.attrColor,
              }.toList(),
              orderCollection: {
                ...?existingOrder.orderCollection,
                product.attrCollection,
              }.toList(),
              orderVyshyvka: {
                ...?existingOrder.orderVyshyvka,
                if (product.attrVyshyvka.isNotEmpty) product.attrVyshyvka,
              }.toList(),
              orderTextile: {
                ...existingOrder.orderTextile,
                if (product.attrTextile.isNotEmpty) product.attrTextile,
              }.toList(),
              orderPrint: {
                ...?existingOrder.orderPrint,
                if (product.attrPrint.isNotEmpty) product.attrPrint,
              }.toList(),
            );
          } else {
            // Add a new grouped order
            groupedOrders[docNumber] = OrdersModel(
              orderId: docNumber,
              startOrder: startOrder,
              orderName: product.itemName,
              orderQuantity: product.quantity.toInt(),
              orderColors: [product.attrColor],
              orderCollection: [product.attrCollection],
              orderVyshyvka: [
                if (product.attrVyshyvka.isNotEmpty) product.attrVyshyvka,
              ],
              orderTextile: [
                if (product.attrTextile.isNotEmpty) product.attrTextile,
              ],
              orderPrint: [
                if (product.attrPrint.isNotEmpty) product.attrPrint,
              ],
            );
          }
        }
      }

      // Convert grouped orders to a list
      return groupedOrders.values.toList();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetOrdersListFailure(error), stackTrace);
    }
  }
}
