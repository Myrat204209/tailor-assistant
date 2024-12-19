// import 'dart:async';
// import 'package:dap_foreman_assis/orders/orders.dart';
// import 'package:bloc/bloc.dart';
// import 'package:dap_foreman_assis/orders/ui/bloc/orders_bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'app_event.dart';
// part 'app_state.dart';

// class AppBloc extends Bloc<AppEvent, AppState> {
//   AppBloc() : super(const AppState.initial()) {
//     // on<App>();
//     on<AppStarted>(_onStarted);
//     on<AppDataRefreshRequested>(_onDataRefreshRequested);
//     on<AppNetworkChecked>(_onNetworkChecked);
//   }
//   FutureOr<void> _onStarted(
//     AppStarted event,
//     Emitter<AppState> emit,
//   ) async {
//     emit(state.copyWith(status: AppStatus.loading));
//     try {
//       add(const OrdersRequested());
//       // await Future.delayed(const Duration(seconds: 2));

//       emit(state.copyWith(status: AppStatus.success));
//     } catch (error) {
//       emit(state.copyWith(status: AppStatus.failure));
//       addError(error);
//     }
//   }
// }
