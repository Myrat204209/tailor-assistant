import 'dart:async';
import 'dart:developer';

import 'package:data_provider/data_provider.dart';

class ReportBoxClient {
  ReportBoxClient({required UserReportsBox reportsBox})
      : _reportsBox = reportsBox;

  final UserReportsBox _reportsBox;

  // Fetch the orders for a given employee
  Future<List<OrderMap>> getOrders({
    required EmployeesItem employee,
  }) async {
    try {
      log('BoxClient - Fetching orders for employee: ${employee.employeeName}');
      final orders = _reportsBox.get(employee.employeeCode);

      log('BoxClient - Fetching orders runtimetype: ${orders.runtimeType}');
      if (orders == null) {
        await addEmployee(
          employee: employee,
          orders: <OrderMap>[],
        );
      }

      return orders ?? <OrderMap>[];
    } catch (error, stackTrace) {
      throw Exception(
        'BoxClient - Error getting orders error: $error, stackTrace: $stackTrace ',
      );
    }
  }

  // Add a new employee if orders do not exist, or update the existing ones
  Future<void> addEmployee({
    required EmployeesItem employee,
    required List<OrderMap> orders,
  }) async {
    try {
      if (_reportsBox.containsKey(employee.employeeCode)) {
        if (orders.isEmpty) return;
      }
      await _reportsBox.put(employee.employeeCode, orders);
    } catch (error, stackTrace) {
      throw Exception(
        'BoxClient - adding employee - ${employee.employeeName} exception: $error, stackTrace : $stackTrace',
      );
    }
  }

  Future<void> addOrder({
    required EmployeesItem employee,
    required OrderItem order,
    List<OperationMap>? operations,
  }) async {
    try {
      log('BoxClient - addOrder Employee - ${employee.employeeName}; order: $order');

      // Fetch current orders before update
      final employeeOrders = await getOrders(employee: employee);

      var orderExists = false;
      for (final empOrder in employeeOrders) {
        if (empOrder.key == order.itemCode) {
          // Check by key directly
          orderExists = true;
          empOrder.operationMaps.addAll(operations ?? <OperationMap>[]);
        }
      }

      if (!orderExists) {
        // If order doesn't exist, add a new order
        employeeOrders.add(OrderMap(
            key: order.itemCode,
            operationMaps: operations ?? <OperationMap>[]));
      }

      await addEmployee(employee: employee, orders: employeeOrders);

      log('Order added successfully for ${employee.employeeName}');
    } catch (error, stackTrace) {
      throw Exception(
        'BoxClient - Error adding order - ${employee.employeeName} exception: $error, stacktrace: $stackTrace',
      );
    }
  }

  Future<List<OperationMap>> getOperations({
    required EmployeesItem employee,
    required OrderItem order,
  }) async {
    try {
      log('BoxClient - getOperations Employee - $employee; order: $order');

      final employeeOrders = await getOrders(employee: employee);
      for (final orderMap in employeeOrders) {
        if (orderMap.key == order.itemCode) {
          // Access key directly
          return orderMap
              .operationMaps; // Return the list of operations directly
        }
      }
      return <OperationMap>[];
    } catch (error, stackTrace) {
      throw Exception(
        'BoxClient - Error getting operations for employee - ${employee.employeeName} exception: $error and stacktrace: $stackTrace',
      );
    }
  }

  // Add an operation to an order
  Future<void> addOperation({
    required EmployeesItem employee,
    required OrderItem order,
    required OperationItem operation,
    required int quantity,
  }) async {
    try {
      log('BoxClient - addOperation Employee - $employee; order: $order - $operation');

      // Fetch existing operations for the given order
      final existingOperations =
          await getOperations(employee: employee, order: order);

      // Add the new operation to the existing ones
      final updatedOperations = <OperationMap>[
        ...(existingOperations),
        OperationMap(key: operation.workCode, value: quantity),
      ];

      // Update the order with new operations
      await addOrder(
        employee: employee,
        order: order,
        operations: updatedOperations,
      );

      log('Operation added successfully for ${employee.employeeName}');
    } catch (error, stackTrace) {
      throw Exception(
        'BoxClient - Error adding operation - ${employee.employeeName} exception: $error, stacktrace : $stackTrace',
      );
    }
  }

  // Fetch quantities (operations) for a given employee, order, and operation
  Future<OperationMap> getQuantities({
    required EmployeesItem employee,
    required OrderItem order,
    required OperationItem operation,
  }) async {
    try {
      log('BoxClient - getQuantities Employee - $employee; order: $order - $operation');
      final orderOperations = await getOperations(
        employee: employee,
        order: order,
      );
      for (final operationMap in orderOperations ) {
        if (operationMap.key == operation.workCode) {
          return operationMap;
        }
      }
      return OperationMap(key: operation.workCode, value: 0);
    } catch (error, stackTrace) {
      throw Exception(
        'BoxClient - Error getting quantities for employee - ${employee.employeeName} exception: $error, stacktrace: $stackTrace ',
      );
    }
    
  }

  // Clear all reports in the box
  void clearAllReports() => _reportsBox.clear();
}
