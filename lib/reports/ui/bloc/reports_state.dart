part of 'reports_bloc.dart';

enum ReportsStatus { initial, loading, success, failure }

final class ReportsState extends Equatable {
  const ReportsState({
    required this.status,
    this.employee,
    this.operations,
    this.orders ,
  });

  const ReportsState.initial() : this(status: ReportsStatus.initial);

  final ReportsStatus status;
  final List<OperationMap>? operations;
  final List<OrderMap>? orders;
  final EmployeesItem? employee;

  @override
  List<Object?> get props => [status, operations, orders, employee];

  ReportsState copyWith({
    ReportsStatus? status,
    List<OperationMap>? operations,
    List<OrderMap>? orders,
    EmployeesItem? employee,
  }) {
    return ReportsState(
      status: status ?? this.status,
      operations: operations ?? this.operations,
      orders: orders ?? orders,
      employee: employee?? this.employee,
    );
  }
}
