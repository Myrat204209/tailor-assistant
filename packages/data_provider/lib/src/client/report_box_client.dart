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
      // Log the initiation of fetching orders for a specific employee
      log('BoxClient - Fetching orders for employee: ${employee.employeeName}');

      // Retrieve the data from Hive using the employeeCode as the key
      final dynamic data = _reportsBox.get(employee.employeeCode);

      // Log the runtime type of the retrieved data for debugging purposes
      log('BoxClient - Retrieved data type: ${data.runtimeType}');

      List<OrderMap> orders;

      if (data == null) {
        // If no orders are found for the employee, initialize an empty list
        orders = <OrderMap>[];

        // Optionally, you can add the employee with an empty orders list
        await addEmployee(
          employee: employee,
          orders: orders,
        );
      } else if (data is List<OrderMap>) {
        // If the data is already a List<OrderMap>, assign it directly
        orders = data;
      } else if (data is List) {
        // If the data is a List<dynamic>, attempt to cast each element to OrderMap
        try {
          orders = data.map<OrderMap>((item) {
            if (item is OrderMap) {
              return item;
            } else {
              throw Exception(
                  'BoxClient - Invalid item type in orders list: ${item.runtimeType}');
            }
          }).toList();
        } catch (castError) {
          // If casting fails, throw a descriptive exception
          throw Exception('BoxClient - Error casting orders: $castError');
        }
      } else {
        // If the data is neither null nor a List, throw an exception
        throw Exception(
            'BoxClient - Unexpected data type: ${data.runtimeType}');
      }

      // Log the successful retrieval and casting of orders
      log('BoxClient - Fetched orders runtime type: ${orders.runtimeType}');

      // Return the list of orders
      return orders;
    } catch (error, stackTrace) {
      // Log the error details for debugging
      log('BoxClient - Exception: $error, StackTrace: $stackTrace');

      // Rethrow the exception with a descriptive message
      throw Exception(
        'BoxClient - Error getting orders: $error\nStackTrace: $stackTrace',
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

  Future<void> addOperation({
    required EmployeesItem employee,
    required OrderItem order,
    required OperationItem operation,
    required int quantity,
  }) async {
    try {
      log('BoxClient - addOperation Employee - $employee; order: $order - $operation');

      // Fetch current orders for the employee
      final employeeOrders = await getOrders(employee: employee);

      // Find the specific order
      final existingOrderIndex = employeeOrders
          .indexWhere((orderMap) => orderMap.key == order.itemCode);

      if (existingOrderIndex != -1) {
        // Order exists, check if operation already exists
        final existingOperationIndex = employeeOrders[existingOrderIndex]
            .operationMaps
            .indexWhere((opMap) => opMap.key == operation.workCode);

        if (existingOperationIndex != -1) {
          // If operation exists, update its quantity
          employeeOrders[existingOrderIndex]
                  .operationMaps[existingOperationIndex] =
              OperationMap(key: operation.workCode, value: quantity);
        } else {
          // If operation doesn't exist, add new operation
          employeeOrders[existingOrderIndex]
              .operationMaps
              .add(OperationMap(key: operation.workCode, value: quantity));
        }
      } else {
        // If order doesn't exist, create a new order with the operation
        employeeOrders.add(OrderMap(key: order.itemCode, operationMaps: [
          OperationMap(key: operation.workCode, value: quantity)
        ]));
      }

      // Save updated orders
      await addEmployee(employee: employee, orders: employeeOrders);

      log('Operation added successfully for ${employee.employeeName}');
    } catch (error, stackTrace) {
      throw Exception(
        'BoxClient - Error adding operation - ${employee.employeeName} exception: $error, stacktrace : $stackTrace',
      );
    }
  }


  /// Constructs and returns a list of ReportItem based on the provided employees, orders, and operations.
  Future<List<ReportItem>> sendReportItems({
    required List<EmployeesItem> employees,
    required List<OrderItem> orders,
    required List<OperationItem> operations,
  }) async {
    final reportItems = <ReportItem>[];

    // Step 1: Index the input lists for efficient lookup
    final employeeMap = <String, EmployeesItem>{
      for (final employee in employees) employee.employeeCode: employee,
    };

    final orderMap = <String, OrderItem>{
      for (final order in orders) order.itemCode: order,
    };

    final operationMap = <String, OperationItem>{
      for (final operation in operations) operation.workCode: operation,
    };

    // Step 2: Retrieve all worker keys from the Hive box
    final workers = _reportsBox.keys.cast<String>().toList();

    // Step 3: Iterate over each worker
    for (final employeeCode in workers) {
      // Find the corresponding EmployeesItem
      final employee = employeeMap[employeeCode];
      if (employee == null) {
        log('No EmployeesItem found for employeeCode: $employeeCode');
        continue; // Skip if no matching employee
      }

      // Retrieve the list of OrderMap for this employee
      final dynamic data = _reportsBox.get(employeeCode);
      log('Fetched data for employeeCode $employeeCode: ${data.runtimeType}');

      List<OrderMap> orderMaps;

      if (data == null) {
        // No orders found, initialize empty list
        orderMaps = <OrderMap>[];
        // Optionally, add the employee with empty orders
        await _reportsBox.put(employeeCode, orderMaps);
        log('Initialized empty orders for employeeCode: $employeeCode');
      } else if (data is List<OrderMap>) {
        // Data is already List<OrderMap>
        orderMaps = data;
      } else if (data is List<dynamic>) {
        // Attempt to cast each element to OrderMap
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
          continue; // Skip if casting fails
        }
      } else {
        log('Unexpected data type for employeeCode $employeeCode: ${data.runtimeType}');
        continue; // Skip unexpected data types
      }

      // Iterate through each OrderMap
      for (final orderMapItem in orderMaps) {
        final orderKey = orderMapItem.key;
        final orderItem = orderMap[orderKey];
        if (orderItem == null) {
          log('No OrderItem found for orderKey: $orderKey');
          continue; // Skip if no matching order
        }

        // Iterate through each OperationMap in the current OrderMap
        for (final operationMapItem in orderMapItem.operationMaps) {
          final operationKey = operationMapItem.key;
          final quantity = operationMapItem.value;
          final operationItem = operationMap[operationKey];
          if (operationItem == null) {
            log('No OperationItem found for operationKey: $operationKey');
            continue; // Skip if no matching operation
          }

          // Construct the ReportItem
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

          // Add the ReportItem to the list
          reportItems.add(reportItem);
        }
      }
    }

    return reportItems;
  }

  // Clear all reports in the box
  void clearAllReports() => _reportsBox.clear();
}
