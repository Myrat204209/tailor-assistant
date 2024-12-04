import 'dart:io';

import 'package:auth_repository/auth_repository.dart';
import 'package:dap_foreman_assis/app/app.dart';
import 'package:dap_foreman_assis/employees/data/data.dart';
import 'package:dap_foreman_assis/main/bootstrap/bootstrap.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:data_provider/data_provider.dart';
import 'package:hive_flutter/hive_flutter.dart' show Hive;
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(() async {
    const defaultBaseUrl = 'http://192.168.0.161:3000';
    // const defaultBaseUrl = 'http://95.85.117.102:8545';
    final httpClient = Http(
      defaultBaseUrl: defaultBaseUrl,
    );

    HttpOverrides.global = MyHttpOverrides();

    const permissionClient = PermissionClient();
    await permissionClient.init();
    final storageRepository =
        StorageRepository(permissionClient: permissionClient);

    Hive
      ..registerAdapter(EmployeesItemAdapter())
      ..registerAdapter(OperationItemAdapter())
      ..registerAdapter(OrderItemAdapter());

    // final reportsClient = ReportsClient(httpClient: httpClient);

    final userReportsBox =
        await Hive.openBox<List<OrderMap>>(HiveBoxKeys.userReportsBoxKey);

    final reportBoxClient = ReportBoxClient(reportsBox: userReportsBox);

    final reportsRepository =
        ReportsRepository(reportBoxClient: reportBoxClient);

    final employeesClient = EmployeesClient(httpClient: httpClient);

    final employeesRepository =
        EmployeesRepository(employeesClient: employeesClient);

    final operationClient = OperationClient(httpClient: httpClient);

    final ordersClient = OrderClient(httpClient: httpClient);

    final ordersRepository = OrdersRepository(orderClient: ordersClient);

    final operationRepository =
        OperationRepository(operationClient: operationClient);

    final authRepository = AuthRepository();

    final userRepository = UserRepository();

    return App(
      storageRepository: storageRepository,
      reportsRepository: reportsRepository,
      ordersRepository: ordersRepository,
      authRepository: authRepository,
      userRepository: userRepository,
      operationRepository: operationRepository,
      employeesRepository: employeesRepository,
    );
  });
}
