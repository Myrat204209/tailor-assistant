part of 'employees_bloc.dart';

sealed class EmployeesEvent extends Equatable {
  const EmployeesEvent();

  @override
  List<Object> get props => [];
}

final class EmployeesInitRequested extends EmployeesEvent {}

final class EmployeesRequested extends EmployeesEvent {}
