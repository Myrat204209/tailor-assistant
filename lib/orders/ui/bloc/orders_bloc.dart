import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:equatable/equatable.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc({required OrdersRepository ordersRepository})
      : _ordersRepository = ordersRepository,
        super(const OrdersState.initial()) {
    on<OrdersRequested>(_onRequested);
  }
  final OrdersRepository _ordersRepository;

  FutureOr<void> _onRequested(
    OrdersRequested event,
    Emitter<OrdersState> emit,
  ) async {
    if (state.status == OrdersStatus.loading ||
        state.status == OrdersStatus.success) {
      return;
    }
    emit(state.copyWith(status: OrdersStatus.loading));
    try {
      final orders = await _ordersRepository.getOrders();
      emit(
        state.copyWith(
          status: OrdersStatus.success,
          orders: orders,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: OrdersStatus.failure));
      addError(error);
    }
  }
}
