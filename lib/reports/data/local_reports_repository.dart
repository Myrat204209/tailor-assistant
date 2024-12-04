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

class GetOrdersFailure extends ReportsFailure {
  const GetOrdersFailure(super.error);
}

class GetOperationsFailure extends ReportsFailure {
  const GetOperationsFailure(super.error);
}

class AddOrdersFailure extends ReportsFailure {
  const AddOrdersFailure(super.error);
}

class AddEmployeesFailure extends ReportsFailure {
  const AddEmployeesFailure(super.error);
}

class AddOperationsFailure extends ReportsFailure {
  const AddOperationsFailure(super.error);
}

class ClearReportsFailure extends ReportsFailure {
  const ClearReportsFailure(super.error);
}

// Repository interacting with ReportBoxClient
class ReportsRepository {
  const ReportsRepository({
    required ReportBoxClient reportBoxClient, // Use ReportBoxClient here
  }) : _reportBoxClient = reportBoxClient;

  final ReportBoxClient _reportBoxClient;

  /// Add EmployeeItem to the box if not already exists, otherwise fetch Orders.
  Future<void> addEmployee(EmployeesItem employee) async {
    try {
      await _reportBoxClient.addEmployee(employee: employee);
    } catch (error) {
      log('Error adding employee: $error');
      throw AddEmployeesFailure(error);
    }
  }

  /// Get all OrderItems for the provided EmployeeItem
  Future<List<OrderMap>> getOrders(EmployeesItem employee) async {
    try {
      final employeeData = await _reportBoxClient.getOrders(employee: employee);
      return employeeData ?? [];
    } catch (error) {
      log('Error fetching orders for employee: $error');
      throw GetOrdersFailure(error);
    }
  }

  Future<void> addOrder(EmployeesItem employee, OrderItem order) async {
    try {
      log('--------------------Add Order ---- \nEmployee: + $employee, \nOrder: + $order' );
      await _reportBoxClient.addOrder(employee: employee, order: order);
      log('--------------------Add Order ---- checking.....' );
    } catch (error) {
      log('Error adding order for employee: $error');
      throw AddOrdersFailure(error);
    }
  }

  /// Get all OperationItems for the provided OrderItem
  Future<List<OperationMap>> getOperations(
    EmployeesItem employee,
    OrderItem order,
  ) async {
    try {
      final operations = await _reportBoxClient.getOperations(
        employee: employee,
        order: order,
      );
      return operations ?? [];
    } catch (error) {
      log('Error fetching operations for order: $error');
      throw GetOperationsFailure(error);
    }
  }

  /// Add OperationMap for a given OrderItem and EmployeeItem if not exists
  Future<void> addOperation(
    EmployeesItem employee,
    OrderItem order,
    OperationItem operation,
    int quantity,
  ) async {
    try {
      await _reportBoxClient.addOperation(
        employee: employee,
        order: order,
        operation: operation,
        quantity: quantity,
      );
    } catch (error) {
      log('Error adding operation for employee and order: $error');
      throw AddOperationsFailure(error);
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
      final operationData = await _reportBoxClient.getQuantities(
        employee: employee,
        order: order,
        operation: operation,
      );
      if (operationData != null) {
        await _reportBoxClient.addOperation(
          employee: employee,
          order: order,
          operation: operation,
          quantity: quantity,
        );
      } else {
        log('Operation not found for this order.');
      }
    } catch (error) {
      log('Error adding quantity for operation: $error');
    }
  }

  /// Clear all data in the reports box
  void clearAllReports() {
    try {
      _reportBoxClient.clearAllReports();
    } catch (error) {
      log('Error clearing all reports: $error');
      throw ClearReportsFailure(error);
    }
  }
}
