import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  EmployeesBloc({required EmployeesRepository employeesRepository})
      : _employeesRepository = employeesRepository,
        super(const EmployeesState.initial()) {
    on<EmployeesRequested>(_onRequested);
  }
  final EmployeesRepository _employeesRepository;



  FutureOr<void> _onRequested(
    EmployeesRequested event,
    Emitter<EmployeesState> emit,
  ) async {
    try {
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
}
