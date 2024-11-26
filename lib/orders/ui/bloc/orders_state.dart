part of 'orders_bloc.dart';

enum OrdersStatus { initial, loading, success, failure }

final class OrdersState extends Equatable {
  const OrdersState({
    required this.status,
    this.orders = const [],
  });
  const OrdersState.initial() : this(status: OrdersStatus.initial);
  final OrdersStatus status;
  final List<OrderItem>? orders;

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
}
