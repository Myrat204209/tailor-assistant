import 'dart:developer';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

// Failure classes for the repository (no changes here)
abstract class ReportsFailure with EquatableMixin implements Exception {
  const ReportsFailure(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}

class GetOrderItemsFailure extends ReportsFailure {
  const GetOrderItemsFailure(super.error);
}

class GetOperationItemsFailure extends ReportsFailure {
  const GetOperationItemsFailure(super.error);
}

class SaveOrderMapFailure extends ReportsFailure {
  const SaveOrderMapFailure(super.error);
}

class SaveOperationMapFailure extends ReportsFailure {
  const SaveOperationMapFailure(super.error);
}

class ClearReportsFailure extends ReportsFailure {
  const ClearReportsFailure(super.error);
}

class ReportsRepository {
  const ReportsRepository({
    required UserReportsBox reportsBox,
  }) : _reportsBox = reportsBox;

  final UserReportsBox _reportsBox;

  /// Add EmployeeItem to the box if not already exists, otherwise fetch Orders.
  Future<void> addEmployee(EmployeesItem employee) async {
    try {
      final employeeData = _reportsBox.get(employee);
      if (employeeData == null) {
        // If the employee does not exist in the box, create a new entry
        await _reportsBox.put(employee, []);
      } else {
        // If the employee exists, retrieve their orders
        await getOrders(employee);
      }
    } catch (error, stackTrace) {
      log('Error adding employee: $error');
    }
  }

  /// Get all OrderItems for the provided EmployeeItem
  Future<List<OrderMap>> getOrders(EmployeesItem employee) async {
    try {
      final employeeData = _reportsBox.get(employee);
      if (employeeData != null) {
        return employeeData.expand((orderMap) => orderMap.values).toList();
      }
      return [];
    } catch (error, stackTrace) {
      log('Error fetching orders for employee: $error');
      return [];
    }
  }

  /// Add OrderItem for a given EmployeeItem if not exists, otherwise fetch operations
  Future<void> addOrder(EmployeesItem employee, OrderItem order) async {
    try {
      final employeeData = _reportsBox.get(employee);
      if (employeeData != null) {
        final existingOrderMap = employeeData.firstWhere(
          (orderMap) => orderMap.containsKey(order),
          orElse: () => {},
        );

        if (existingOrderMap.isEmpty) {
          // If OrderItem doesn't exist, add it to the employee's data
          final newOrderMap = {order: []};
          employeeData.add(newOrderMap);
          await _reportsBox.put(employee, employeeData);
        } else {
          // If OrderItem exists, fetch operations for this order
          await getOperations(employee, order);
        }
      } else {
        log('Employee does not exist in the box.');
      }
    } catch (error, stackTrace) {
      log('Error adding order for employee: $error');
    }
  }

  /// Get all OperationItems for the provided OrderItem
  Future<List<OperationMap>> getOperations(
    EmployeesItem employee,
    OrderItem order,
  ) async {
    try {
      final employeeData = _reportsBox.get(employee);
      if (employeeData != null) {
        for (final orderMap in employeeData) {
          if (orderMap.containsKey(order)) {
            return orderMap[order]!;
          }
        }
      }
      return [];
    } catch (error, stackTrace) {
      log('Error fetching operations for order: $error');
      return [];
    }
  }

  /// Add OperationMap for a given OrderItem and EmployeeItem if not exists
  Future<void> addOperation(
    EmployeesItem employee,
    OrderItem order,
    List<OperationMap> operationMaps,
  ) async {
    try {
      final employeeData = _reportsBox.get(employee);
      if (employeeData != null) {
        var orderFound = false;

        for (final orderMap in employeeData) {
          if (orderMap.containsKey(order)) {
            orderMap[order]!.addAll(operationMaps);
            await _reportsBox.put(employee, employeeData);
            orderFound = true;
            break;
          }
        }

        if (!orderFound) {
          employeeData.add({order: operationMaps});
          await _reportsBox.put(employee, employeeData);
        }
      }
    } catch (error, stackTrace) {
      log('Error adding operation for employee and order: $error');
    }
  }

  /// Add Quantity for a given OperationItem under an OrderItem for an EmployeeItem
  Future<void> addQuantity(
    EmployeesItem employee,
    OrderItem order,
    OperationItem operation,
    int quantity,
  ) async {
    try {
      final employeeData = _reportsBox.get(employee);
      if (employeeData != null) {
        for (final orderMap in employeeData) {
          if (orderMap.containsKey(order)) {
            final operationMapList = orderMap[order];
            for (final operationMap in operationMapList!) {
              if (operationMap.containsKey(operation)) {
                operationMap[operation] = quantity;
                await _reportsBox.put(employee, employeeData);
                return; // Exit after updating the quantity
              }
            }
          }
        }
        log('Operation not found for this order.');
      }
    } catch (error, stackTrace) {
      log('Error adding quantity for operation: $error');
    }
  }

  /// Clear all data in the reports box
  Future<void> clearAllReports() async {
    try {
      await _reportsBox.clear();
    } catch (error, stackTrace) {
      log('Error clearing all reports: $error');
    }
  }
}
