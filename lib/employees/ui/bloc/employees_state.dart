// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'employees_bloc.dart';

enum EmployeesStatus { initial, loading, success, failure }

class EmployeesState extends Equatable {
  const EmployeesState({
    required this.status,
    this.employees = const [],
  });
  const EmployeesState.initial() : this(status: EmployeesStatus.initial);
  final EmployeesStatus status;
  final List<EmployeesItem> employees;

  @override
  List<Object> get props => [status, employees];

  EmployeesState copyWith({
    EmployeesStatus? status,
    List<EmployeesItem>? employees,
  }) {
    return EmployeesState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
    );
  }

  factory EmployeesState.fromJson(Map<String, dynamic> json) {
    return EmployeesState(
      status: EmployeesStatus.values[json['status'] as int],
      employees: (json['employees'] as List<dynamic>)
          .map((employeeJson) =>
              EmployeesItem.fromJson(employeeJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.index,
      'employees': employees.map((employee) => employee.toJson()).toList(),
    };
  }
}
