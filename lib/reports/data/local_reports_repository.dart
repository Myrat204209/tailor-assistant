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

  /// Get all OrderItems for a given EmployeeItem
  Future<List<OrderMap>> getOrders({required EmployeesItem employee}) async {
    try {
      final employeeData = _reportsBox.get(employee);
      if (employeeData == null) {
        return [];
      }

      return employeeData[employee] ?? [];
    } catch (error) {
      log('Error fetching order items for employee: $error');
      return [];
    }
  }

  /// Get all OperationItems and their int values for a given OrderItem of a specific EmployeeItem
  Future<List<OperationMap>> getOperationItemsForOrder({
    required EmployeesItem employee,
    required OrderItem order,
  }) async {
    try {
      // Fetch the employee data
      final employeeData = _reportsBox.get(employee);

      if (employeeData == null) {
        return [];
      }
      final employeeOrders = employeeData[employee] ?? [];

      // Loop through the employee's order list
      for (final orderMap in employeeOrders) {
        // Check if the current OrderMap contains the given OrderItem
        if (orderMap.containsKey(order)) {
          // Return all OperationMaps for the provided OrderItem
          return List<OperationMap>.from(orderMap[order] ?? []);
        }
      }

      // If no OrderItem found, return empty list
      return [];
    } catch (error, stackTrace) {
      log('Error fetching operation items for order: $error');
      return []; // Return empty list in case of error
    }
  }

  /// Save OperationMaps to the provided OrderItem
  Future<void> saveOperationMapsToOrder(
    OrderItem order,
    List<OperationMap> operationMaps,
  ) async {
    try {
      final allEmployees = _reportsBox.values.toList();

      // Iterate over all employee data
      for (final employeeData in allEmployees) {
        if (employeeData is List<OrderMap>) {
          for (final orderMap in employeeData) {
            // If the order exists, clear the existing operation maps and save the new ones
            if (orderMap.containsKey(order)) {
              orderMap[order]!.clear(); // Clear previous operation maps
              orderMap[order]!.addAll(operationMaps); // Add new operation maps
              await _reportsBox.put(
                order,
                employeeData,
              ); // Save updated employee data
              return;
            }
          }
        }
      }
      log('Failed to save operation maps to order: Order not found');
    } catch (error, stackTrace) {
      log('Error saving operation maps to order: $error');
    }
  }

  /// Save OrderMaps to the provided EmployeeItem
  Future<void> saveOrderMapsToEmployee(
    EmployeesItem employee,
    List<OrderMap> orderMaps,
  ) async {
    try {
      final employeeData = _reportsBox.get(employee);

      if (employeeData != null) {
        // Ensure employeeData is a List<OrderMap>
        if (employeeData is List<OrderMap>) {
          // Clear existing order maps for this employee
          employeeData.clear();
          // Save the new order maps
          employeeData.addAll(orderMaps);
          await _reportsBox.put(employee, employeeData);
        }
      } else {
        // If no data exists for the employee, create a new list
        await _reportsBox.put(employee, [orderMaps]);
      }
    } catch (error, stackTrace) {
      log('Error saving order maps to employee: $error');
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
