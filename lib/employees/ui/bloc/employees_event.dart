part of 'employees_bloc.dart';

sealed class EmployeesEvent extends Equatable {
  const EmployeesEvent();

  @override
  List<Object> get props => [];
}

final class EmployeesRequested extends EmployeesEvent {
  const EmployeesRequested();
}

final class EmployeesRefreshRequested extends EmployeesEvent {
  const EmployeesRefreshRequested();
}
