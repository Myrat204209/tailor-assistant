import 'dart:async';

import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends HydratedBloc<OrdersEvent, OrdersState> {
  OrdersBloc({required OrdersRepository ordersRepository})
      : _ordersRepository = ordersRepository,
        super(const OrdersState.initial()) {
    on<OrdersRequested>(_onRequested);
    on<OrdersRefreshRequested>(_onRefresh);
  }
  final OrdersRepository _ordersRepository;

  FutureOr<void> _onRequested(
    OrdersRequested event,
    Emitter<OrdersState> emit,
  ) async {
    if (state.status == OrdersStatus.loading ||
        (state.status != OrdersStatus.refreshing && state.orders.isNotEmpty)) {
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

  void _onRefresh(
    OrdersRefreshRequested event,
    Emitter<OrdersState> emit,
  ) {
    emit(state.copyWith(status: OrdersStatus.refreshing));
    add(const OrdersRequested());
  }

  @override
  OrdersState? fromJson(JsonType json) {
    try {
      return OrdersState.fromJson(json);
    } catch (_) {
      return const OrdersState.initial();
    }
  }

  @override
  JsonType? toJson(OrdersState state) {
    try {
      return state.toJson();
    } catch (_) {
      return null;
    }
  }
}
