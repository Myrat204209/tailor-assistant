import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

part 'operation_event.dart';
part 'operation_state.dart';

class OperationBloc extends Bloc<OperationEvent, OperationState> {
  OperationBloc({required OperationRepository operationRepository})
      : _operationRepository = operationRepository,
        super(const OperationState.initial()) {
    on<OperationRequested>(_onRequested);
    on<OperationRefreshRequested>(_onRefreshRequested);
  }
  final OperationRepository _operationRepository;
  bool _isFetching = false;
  FutureOr<void> _onRequested(
    OperationRequested event,
    Emitter<OperationState> emit,
  ) async {
    if (_isFetching) return;
    _isFetching = true;
    try {
      emit(state.copyWith(status: OperationStatus.loading));
      final operations = await _operationRepository.getOperations();
      emit(
        state.copyWith(
          status: OperationStatus.success,
          operations: operations,
        ),
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(status: OperationStatus.failure));
      addError(error, stackTrace);
    } finally {
      _isFetching = false;
    }
  }

  void _onRefreshRequested(
    OperationRefreshRequested event,
    Emitter<OperationState> emit,
  ) {
    emit(state.copyWith(status: OperationStatus.initial));
    emit(const OperationState.initial());
    add(const OperationRequested());
  }
}
