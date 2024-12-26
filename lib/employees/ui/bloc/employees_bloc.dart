import 'dart:async';

import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends HydratedBloc<EmployeesEvent, EmployeesState> {
  EmployeesBloc({required EmployeesRepository employeesRepository})
      : _employeesRepository = employeesRepository,
        super(const EmployeesState.initial()) {
    on<EmployeesRequested>(_onRequested);
    on<EmployeesRefreshRequested>(_onRefresh);
  }
  final EmployeesRepository _employeesRepository;

  FutureOr<void> _onRequested(
    EmployeesRequested event,
    Emitter<EmployeesState> emit,
  ) async {
    try {
      if (state.status == EmployeesStatus.loading ||
          state.employees.isNotEmpty) {
        return;
      }
      emit(state.copyWith(status: EmployeesStatus.loading));
      final employees = await _employeesRepository.getEmployees();
      emit(
        state.copyWith(
          status: EmployeesStatus.success,
          employees: employees,
        ),
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(status: EmployeesStatus.failure));
      addError(error, stackTrace);
    }
  }

  void _onRefresh(
    EmployeesRefreshRequested event,
    Emitter<EmployeesState> emit,
  ) {
    add(const EmployeesRequested());
  }

  @override
  EmployeesState? fromJson(Map<String, dynamic> json) {
    try {
      return EmployeesState.fromJson(json);
    } catch (_) {
      return const EmployeesState.initial();
    }
  }

  @override
  Map<String, dynamic>? toJson(EmployeesState state) {
    try {
      return state.toJson();
    } catch (_) {
      return null;
    }
  }
}
