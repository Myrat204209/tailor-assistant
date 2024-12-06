part of 'reports_bloc.dart';

sealed class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object> get props => [];
}

sealed class ReportBoxEvent {
  const ReportBoxEvent();
}

final class ReportOrdersRequested extends ReportBoxEvent {
  const ReportOrdersRequested({required this.employee});
  final EmployeesItem employee;
}

final class ReportOrderAdded extends ReportBoxEvent {
  const ReportOrderAdded(this.employee, this.order);
  final EmployeesItem employee;
  final OrderItem order;
}

final class ReportOperationsRequested extends ReportBoxEvent {
  const ReportOperationsRequested(
      {required this.employee, required this.order});
  final EmployeesItem employee;
  final OrderItem order;
}

final class ReportOperationAdded extends ReportBoxEvent {
  const ReportOperationAdded({
    required this.employee,
    required this.order,
    required this.operation,
    required this.quantity,
  });
  final EmployeesItem employee;
  final OrderItem order;
  final OperationItem operation;
  final int quantity;
}

final class ReportsCleared extends ReportBoxEvent {
  const ReportsCleared();
}
