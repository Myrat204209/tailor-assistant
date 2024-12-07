part of 'reports_bloc.dart';

enum ReportsStatus { initial, loading, success, failure }

final class ReportsState extends Equatable {
  const ReportsState({
    required this.status,
    this.employee,
    this.operations,
    this.reports = const [],
    this.isFetching = false,
    this.orders,
  });

  const ReportsState.initial() : this(status: ReportsStatus.initial);

  final ReportsStatus status;
  final List<OperationMap>? operations;
  final List<OrderMap>? orders;
  final EmployeesItem? employee;
  final List<ReportItem> reports;
  final bool isFetching;
  @override
  List<Object?> get props => [status, operations, orders, employee];

  String getQuantity(String workCode) {
    return operations
            ?.firstWhere(
              (element) => element.key == workCode,
              orElse: () => OperationMap(key: '', value: 0),
            )
            .value
            .toString() ??
        '0';
  }

  ReportsState copyWith({
    ReportsStatus? status,
    List<OperationMap>? operations,
    List<OrderMap>? orders,
    bool? isFetching,
    List<ReportItem>? reports,
    EmployeesItem? employee,
  }) {
    return ReportsState(
      status: status ?? this.status,
      operations: operations ?? this.operations,
      orders: orders ?? orders,
      employee: employee ?? this.employee,
      isFetching: isFetching ?? this.isFetching,
      reports: reports ?? this.reports,
    );
  }

  @override
  String toString() {
    final empName = employee?.employeeName ?? 'No employee';
    final operationsKeys = operations?.isNotEmpty ?? false
        ? operations?.map((op) => op.key).join(', ') ?? 'No operations'
        : 'No operations';
    final ordersKeys = orders?.isNotEmpty ?? false
        ? orders?.map((order) => order.key).join(', ') ?? 'No orders'
        : 'No orders';

    return '''
    ReportsState{
      status: $status, 
      emp: $empName, 
      operations: $operationsKeys, 
      orders: $ordersKeys
    }
  ''';
  }
}
