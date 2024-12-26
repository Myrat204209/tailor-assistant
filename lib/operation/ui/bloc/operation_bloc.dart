import 'dart:async';

import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'operation_event.dart';
part 'operation_state.dart';

class OperationBloc extends HydratedBloc<OperationEvent, OperationState> {
  OperationBloc({required OperationRepository operationRepository})
      : _operationRepository = operationRepository,
        super(const OperationState.initial()) {
    on<OperationRequested>(_onRequested);
    on<OperationRefreshRequested>(_onRefresh);
  }
  final OperationRepository _operationRepository;

  FutureOr<void> _onRequested(
    OperationRequested event,
    Emitter<OperationState> emit,
  ) async {
    if (state.status == OperationStatus.loading) return;
    emit(state.copyWith(status: OperationStatus.loading));

    try {
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
    }
  }

  void _onRefresh(
    OperationRefreshRequested event,
    Emitter<OperationState> emit,
  ) {
    add(const OperationRequested());
  }

  @override
  OperationState? fromJson(Map<String, dynamic> json) {
    try {
      return OperationState.fromJson(json);
    } catch (_) {
      return const OperationState.initial();
    }
  }

  @override
  Map<String, dynamic>? toJson(OperationState state) {
    try {
      return state.toJson();
    } catch (_) {
      return null;
    }
  }
}
