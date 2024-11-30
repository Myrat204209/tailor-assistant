part of 'orders_bloc.dart';

enum OrdersStatus { initial, loading, success, failure }

class OrdersState extends Equatable {
  const OrdersState({
    required this.status,
    this.orders = const [],
  });

  // Create OrdersState from JSON
  factory OrdersState.fromJson(JsonType json) {
    return OrdersState(
      status: OrdersStatus.values[json['status'] as int],
      orders: (json['orders'] as List<dynamic>)
          .map(
            (orderJson) =>
                OrderItem.fromJson(orderJson as JsonType),
          )
          .toList(),
    );
  }

  const OrdersState.initial() : this(status: OrdersStatus.initial);

  final OrdersStatus status;
  final List<OrderItem> orders;

  @override
  List<Object?> get props => [status, orders];

  OrdersState copyWith({
    OrdersStatus? status,
    List<OrderItem>? orders,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
    );
  }

  // Convert OrdersState to JSON
  JsonType toJson() {
    return {
      'status': status.index, // Enum to int
      'orders': orders.map((order) => order.toJson()).toList(),
    };
  }
}
