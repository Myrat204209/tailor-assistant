part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

final class OrdersRequested extends OrdersEvent {
  const OrdersRequested();
}

final class OrdersRefreshRequested extends OrdersEvent {
  const OrdersRefreshRequested();
}
