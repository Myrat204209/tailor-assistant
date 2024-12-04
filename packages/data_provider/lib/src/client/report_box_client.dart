import 'dart:async';
import 'dart:developer';
import 'package:data_provider/data_provider.dart';

class ReportBoxClient {
  ReportBoxClient({required UserReportsBox reportsBox})
      : _reportsBox = reportsBox;

  final UserReportsBox _reportsBox;

  // Fetch the orders for a given employee
  Future<List<OrderMap>?> getOrders({required EmployeesItem employee}) async {
    try {
      if (_reportsBox.containsKey(employee.employeeCode)) {
        // Ensure the list is mutable
        log('_--------This key is already in the list. Key : ${employee.employeeName}');
        return List<OrderMap>.from(
          _reportsBox.get(employee.employeeCode) ?? [],
        );
      } else {
        log('_--------No orders found for employee: ${employee.employeeName}');
        return [];
      }
    } catch (error) {
      throw Exception('Getting orders for employee - $employee exception: $error');
    }
  }

  // Add an employee and their orders to the reports box
  FutureOr<void> addEmployee({
    required EmployeesItem employee,
    List<OrderMap>? orders,
  }) async {
    try {
      log('------------addEmployee Employee - $employee; orders: $orders');
      if (_reportsBox.containsKey(employee.employeeCode)) {
        log('_--------This key is already in the list. Key : ${employee.employeeName}. Orders: $orders');
      } else {
        log('_--------Key is NOT in the list. Adding Employee: ${employee.employeeName}');
        await _reportsBox.put(employee.employeeCode, orders ?? []);
      }
    } catch (error) {
      throw Exception('Error adding employee: $employee exception: $error');
    }
  }

  // Fetch operations for a given employee and order
  Future<List<OperationMap>?> getOperations({
    required EmployeesItem employee,
    required OrderItem order,
  }) async {
    try {
      log('------------getOperations Employee - $employee; order: $order');
      final employeeOrders = await getOrders(employee: employee);
      if (employeeOrders != null) {
        for (final orderMap in employeeOrders) {
          if (orderMap.containsKey(order)) {
            return orderMap[order];
          }
        }
        await addOrder(employee: employee, order: order);
        return [];
      }
    } catch (error) {
      throw Exception('Error getting operations for employee: $employee exception: $error');
    }
    return null;
  }

  // Add a new order for an employee
  FutureOr<void> addOrder({
    required EmployeesItem employee,
    required OrderItem order,
    List<OperationMap> operations = const [],
  }) async {
    try {
      log('-----------addOrder Employee - $employee; order: $order');
      final employeeOrders = await getOrders(employee: employee);
      if (employeeOrders == null || employeeOrders.isEmpty) {
        log('------This Order: $order is NOT in the Employee - $employee');
        await addEmployee(
          employee: employee,
          orders: [
            {order: operations},
          ],
        );
      } else {
        log('------Order already exists. Updating order for employee: $employee');
        final updatedOrders = List<OrderMap>.from(employeeOrders)
          ..add({order: operations});
        await addEmployee(employee: employee, orders: updatedOrders);
      }
    } catch (error) {
      throw Exception('Error adding order for employee: $employee exception: $error');
    }
  }

  // Fetch quantities (operations) for a given employee, order, and operation
  Future<OperationMap?> getQuantities({
    required EmployeesItem employee,
    required OrderItem order,
    required OperationItem operation,
  }) async {
    try {
      log('-----------getQuantities Employee - $employee; order: $order - operation: $operation');

      final orderOperations = await getOperations(
        employee: employee,
        order: order,
      );
      if (orderOperations != null) {
        for (final operationMap in orderOperations) {
          if (operationMap.containsKey(operation)) {
            return operationMap;
          }
        }
      }
    } catch (error) {
      throw Exception('Error getting quantities for employee: $employee exception: $error');
    }
    return null;
  }

  // Add a new operation for a given employee and order
  FutureOr<void> addOperation({
    required EmployeesItem employee,
    required OrderItem order,
    required OperationItem operation,
    required int quantity,
  }) async {
    try {
      log('-----------addOperation Employee - $employee; order: $order - operation: $operation - quantity: $quantity');
      final orderOperations = await getOperations(
        employee: employee,
        order: order,
      );
      if (orderOperations != null) {
        final updatedOperations = List<Map<OperationItem, int>>.from(orderOperations)
          ..add({operation: quantity});
        await addOrder(
          employee: employee,
          order: order,
          operations: updatedOperations,
        );
      }
    } catch (error) {
      throw Exception('Error adding operation for employee: $employee exception: $error');
    }
  }

  // Clear all reports in the box
  void clearAllReports() => _reportsBox.clear();
}
