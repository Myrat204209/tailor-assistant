// ignore_for_file: unnecessary_await_in_return

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

      // Because _reportsBox is typed as Box<List<OrderMap>>,
      // this will be List<OrderMap>? (null if not found, otherwise a valid list)
      final boxData =
          _reportsBox.get(employee.employeeCode, defaultValue: <OrderMap>[])!;
      final ordersInBox = boxData.map((e) => e as OrderMap).toList();
      log('BoxClient - Retrieved data type: ${ordersInBox.runtimeType}');

      // If the box has no data for the key, initialize with an empty list
      // ordersInBox is already a List<OrderMap>, so just return it
      return ordersInBox;
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
      // If the box already has data for this employee and
      // the new list is empty, there's nothing to add
      if (_reportsBox.containsKey(employee.employeeCode) && orders.isEmpty) {
        return;
      }
      // No need to cast to <OrderMap> because 'orders' is already List<OrderMap>
      await _reportsBox.put(employee.employeeCode, orders.cast<OrderMap>());
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
          // Add new operations if provided
          empOrder.operationMaps
              .addAll(operations?.cast<OperationMap>() ?? <OperationMap>[]);
        }
      }

      // If order not found, create a new OrderMap
      if (!orderExists) {
        employeeOrders.add(
          OrderMap(
            key: order.docNumber,
            operationMaps: operations?.cast<OperationMap>() ?? <OperationMap>[],
          ),
        );
      }

      await addEmployee(
          employee: employee, orders: employeeOrders.cast<OrderMap>());
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
          return orderMap.operationMaps.cast<OperationMap>();
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
          // Update the existing operation's quantity
          employeeOrders[existingOrderIndex]
                  .operationMaps[existingOperationIndex] =
              OperationMap(key: operation.workCode, value: quantity);
        } else {
          // Add a new operation to the existing order
          employeeOrders[existingOrderIndex]
              .operationMaps
              .add(OperationMap(key: operation.workCode, value: quantity));
        }
      } else {
        // Create a brand-new order if none exists for this docNumber
        employeeOrders.add(
          OrderMap(
            key: order.docNumber,
            operationMaps: [
              OperationMap(key: operation.workCode, value: quantity),
            ],
          ),
        );
      }

      await addEmployee(
          employee: employee, orders: employeeOrders.cast<OrderMap>());
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

    // Each employeeCode stored in the box
    final workers = _reportsBox.keys.cast<String>().toList();

    for (final employeeCode in workers) {
      final employee = employeeMap[employeeCode];
      if (employee == null) {
        log('No EmployeesItem found for employeeCode: $employeeCode');
        continue;
      }

      // Already typed as List<OrderMap>?
      final boxDataMaps = _reportsBox.get(employeeCode)!;
      final orderMaps = boxDataMaps.map((e) => e as OrderMap).toList();
      log('Fetched data for employeeCode $employeeCode: ${orderMaps.runtimeType}');

      // Build report items based on each OrderMap and its OperationMaps
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

  Future<int> getNumberOfOperations(EmployeesItem employee) async {
    try {
      final orders = await getOrders(employee: employee);
      var operationCount = 0;
      for (final order in orders) {
        operationCount += order.operationMaps.length;
      }
      return operationCount;
    } catch (error, stackTrace) {
      log('Error getting number of operations for employeeCode ${employee.employeeCode}: $error, stackTrace: $stackTrace');
      throw Exception(
          'Error getting number of operations: $error\nStackTrace: $stackTrace');
    }
  }

  Future<void> clearAllReports() async => await _reportsBox.clear().then(
        (value) {
          final keys = _reportsBox.keys;
          _reportsBox.deleteAll(keys);
        },
      );
}
