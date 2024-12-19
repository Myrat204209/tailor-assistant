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

      final dynamic data = _reportsBox.get(employee.employeeCode);
      log('BoxClient - Retrieved data type: ${data.runtimeType}');

      if (data == null) {
        final orders = <OrderMap>[];
        await addEmployee(employee: employee, orders: orders);
        return orders;
      } else if (data is List) {
        try {
          return data.map<OrderMap>((item) {
            if (item is OrderMap) {
              return item;
            } else {
              throw Exception(
                  'Invalid item type in orders list: ${item.runtimeType}');
            }
          }).toList();
        } catch (castError) {
          throw Exception('Error casting orders: $castError');
        }
      } else {
        throw Exception('Unexpected data type: ${data.runtimeType}');
      }
    } catch (error, stackTrace) {
      log('BoxClient - Exception: $error, StackTrace: $stackTrace');
      throw Exception('Error getting orders: $error\nStackTrace: $stackTrace');
    }
  }

  // Add a new employee if orders do not exist, or update the existing ones
  Future<void> addEmployee({
    required EmployeesItem employee,
    required List<OrderMap> orders,
  }) async {
    try {
      if (_reportsBox.containsKey(employee.employeeCode) && orders.isEmpty) {
        return;
      }
      await _reportsBox.put(employee.employeeCode, orders);
    } catch (error, stackTrace) {
      throw Exception(
          'Error adding employee - ${employee.employeeName}: $error, stackTrace: $stackTrace');
    }
  }

  Future<void> addOrder({
    required EmployeesItem employee,
    required OrderItem order,
    List<OperationMap>? operations,
  }) async {
    try {
      log('BoxClient - addOrder Employee - ${employee.employeeName}; order: $order');

      final employeeOrders = await getOrders(employee: employee);
      var orderExists = false;

      for (final empOrder in employeeOrders) {
        if (empOrder.key == order.docNumber) {
          orderExists = true;
          empOrder.operationMaps.addAll(operations ?? <OperationMap>[]);
        }
      }

      if (!orderExists) {
        employeeOrders.add(OrderMap(
            key: order.docNumber,
            operationMaps: operations ?? <OperationMap>[]));
      }

      await addEmployee(employee: employee, orders: employeeOrders);
      log('Order added successfully for ${employee.employeeName}');
    } catch (error, stackTrace) {
      throw Exception(
          'Error adding order - ${employee.employeeName}: $error, stacktrace: $stackTrace');
    }
  }

  Future<void> removeOrder({
    required EmployeesItem employee,
    required OrderItem order,
  }) async {
    try {
      log('BoxClient - removeOrder Employee - ${employee.employeeName}; order: $order');

      final employeeOrders = await getOrders(employee: employee);
      final existingOrderIndex = employeeOrders
          .indexWhere((orderMap) => orderMap.key == order.docNumber);

      if (existingOrderIndex != -1) {
        employeeOrders.removeAt(existingOrderIndex);
      }

      await addEmployee(employee: employee, orders: employeeOrders);
      log('Order removed successfully for ${employee.employeeName}');
    } catch (error, stackTrace) {
      throw Exception(
          'Error removing order - ${employee.employeeName}: $error, stacktrace: $stackTrace');
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
        if (orderMap.key == order.docNumber) {
          return orderMap.operationMaps;
        }
      }
      return <OperationMap>[];
    } catch (error, stackTrace) {
      throw Exception(
          'Error getting operations for employee - ${employee.employeeName}: $error, stacktrace: $stackTrace');
    }
  }

  Future<void> addOperation({
    required EmployeesItem employee,
    required OrderItem order,
    required OperationItem operation,
    required int quantity,
  }) async {
    try {
      log('BoxClient - addOperation Employee - $employee; order: $order - $operation');

      final employeeOrders = await getOrders(employee: employee);
      final existingOrderIndex = employeeOrders
          .indexWhere((orderMap) => orderMap.key == order.docNumber);

      if (existingOrderIndex != -1) {
        final existingOperationIndex = employeeOrders[existingOrderIndex]
            .operationMaps
            .indexWhere((opMap) => opMap.key == operation.workCode);

        if (existingOperationIndex != -1) {
          employeeOrders[existingOrderIndex]
                  .operationMaps[existingOperationIndex] =
              OperationMap(key: operation.workCode, value: quantity);
        } else {
          employeeOrders[existingOrderIndex]
              .operationMaps
              .add(OperationMap(key: operation.workCode, value: quantity));
        }
      } else {
        employeeOrders.add(OrderMap(key: order.docNumber, operationMaps: [
          OperationMap(key: operation.workCode, value: quantity)
        ]));
      }

      await addEmployee(employee: employee, orders: employeeOrders);
      log('Operation added successfully for ${employee.employeeName}');
    } catch (error, stackTrace) {
      throw Exception(
          'Error adding operation - ${employee.employeeName}: $error, stacktrace: $stackTrace');
    }
  }

  Future<void> removeOperation({
    required EmployeesItem employee,
    required OrderItem order,
    required OperationItem operation,
  }) async {
    try {
      log('BoxClient - removeOperation Employee - $employee; order: $order - $operation');

      final employeeOrders = await getOrders(employee: employee);
      final existingOrderIndex = employeeOrders
          .indexWhere((orderMap) => orderMap.key == order.docNumber);

      if (existingOrderIndex != -1) {
        final existingOperationIndex = employeeOrders[existingOrderIndex]
            .operationMaps
            .indexWhere((opMap) => opMap.key == operation.workCode);

        if (existingOperationIndex != -1) {
          employeeOrders[existingOrderIndex]
              .operationMaps
              .removeAt(existingOperationIndex);
        }
      }

      await addEmployee(employee: employee, orders: employeeOrders);
      log('Operation removed successfully for ${employee.employeeName}');
    } catch (error, stackTrace) {
      throw Exception(
          'Error removing operation - ${employee.employeeName}: $error, stacktrace: $stackTrace');
    }
  }

  Future<List<ReportItem>> sendReportItems({
    required List<EmployeesItem> employees,
    required List<OrderItem> orders,
    required List<OperationItem> operations,
  }) async {
    final reportItems = <ReportItem>[];

    final employeeMap = <String, EmployeesItem>{
      for (final employee in employees) employee.employeeCode: employee,
    };

    final orderMap = <String, OrderItem>{
      for (final order in orders) order.docNumber: order,
    };

    final operationMap = <String, OperationItem>{
      for (final operation in operations) operation.workCode: operation,
    };

    final workers = _reportsBox.keys.cast<String>().toList();

    for (final employeeCode in workers) {
      final employee = employeeMap[employeeCode];
      if (employee == null) {
        log('No EmployeesItem found for employeeCode: $employeeCode');
        continue;
      }

      final dynamic data = _reportsBox.get(employeeCode);
      log('Fetched data for employeeCode $employeeCode: ${data.runtimeType}');

      List<OrderMap> orderMaps;

      if (data == null) {
        orderMaps = <OrderMap>[];
        await _reportsBox.put(employeeCode, orderMaps);
        log('Initialized empty orders for employeeCode: $employeeCode');
      } else if (data is List) {
        try {
          orderMaps = data.map<OrderMap>((item) {
            if (item is OrderMap) {
              return item;
            } else {
              throw Exception(
                  'Invalid item type in orders list: ${item.runtimeType}');
            }
          }).toList();
        } catch (e) {
          log('Error casting orders for employeeCode $employeeCode: $e');
          continue;
        }
      } else {
        log('Unexpected data type for employeeCode $employeeCode: ${data.runtimeType}');
        continue;
      }

      for (final orderMapItem in orderMaps) {
        final orderKey = orderMapItem.key;
        final orderItem = orderMap[orderKey];
        if (orderItem == null) {
          log('No OrderItem found for orderKey: $orderKey');
          continue;
        }

        for (final operationMapItem in orderMapItem.operationMaps) {
          final operationKey = operationMapItem.key;
          final quantity = operationMapItem.value;
          final operationItem = operationMap[operationKey];
          if (operationItem == null) {
            log('No OperationItem found for operationKey: $operationKey');
            continue;
          }

          final reportItem = ReportItem(
            employeeCode: employee.employeeCode,
            employeeName: employee.employeeName,
            itemCode: orderItem.itemCode,
            itemName: orderItem.itemName,
            docNumber: orderItem.docNumber,
            workCode: operationItem.workCode,
            workName: operationItem.workName,
            reportDate: DateTime.now().toString(),
            workQuantity: quantity,
          );

          reportItems.add(reportItem);
        }
      }
    }

    return reportItems;
  }

  void clearAllReports() => _reportsBox.clear();
}
