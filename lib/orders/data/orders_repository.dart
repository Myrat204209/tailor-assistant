
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
  Future<List<OrderItem>> getOrders() async {
    try {
      final orderItems = await _orderClient.getOrders();

      return orderItems!;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetOrdersListFailure(error), stackTrace);
    }
  }
}
