part of 'reports_bloc.dart';

sealed class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

final class ReportsRequested extends ReportEvent {
  const ReportsRequested();
}

final class ReportsSendRequested extends ReportEvent {
  const ReportsSendRequested(this.reports);
  final List<ReportItem> reports;

  @override
  List<Object> get props => [reports];
}

final class ReportUpdateRequested extends ReportEvent {
  const ReportUpdateRequested(this.id, this.report);
  final int id;
  final ReportItem report;

  @override
  List<Object> get props => [id, report];
}

final class ReportDeleteRequested extends ReportEvent {
  const ReportDeleteRequested(this.id);
  final int id;

  @override
  List<Object> get props => [id];
}

final class ReportEmployeeSelected extends ReportEvent {
  const ReportEmployeeSelected({
    required this.employeeCode,
    required this.employeeName,
  });
  final String employeeCode;
  final String employeeName;

  @override
  List<Object> get props => [employeeCode, employeeName];
}

final class ReportProductSelected extends ReportEvent {
  const ReportProductSelected({required this.product});
  final OrderItem product;

  @override
  List<Object> get props => [product];
}

final class ReportOperationSelected extends ReportEvent {
  const ReportOperationSelected({required this.operation});
  final OperationItem operation;

  @override
  List<Object> get props => [operation];
}

final class ReportQuantityAdded extends ReportEvent {
  const ReportQuantityAdded({
    required this.workCode,
    required this.quantity,
  });
  final String workCode;
  final double quantity;

  @override
  List<Object> get props => [workCode, quantity];
}

final class ReportSaved extends ReportEvent {
  const ReportSaved();
}
