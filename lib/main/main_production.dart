import 'dart:io';

import 'package:auth_repository/auth_repository.dart';
import 'package:dap_foreman_assis/app/app.dart';
import 'package:dap_foreman_assis/employees/data/data.dart';
import 'package:dap_foreman_assis/main/bootstrap/bootstrap.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:dap_foreman_assis/settings/domain/domain.dart';
import 'package:data_provider/data_provider.dart';
import 'package:hive_flutter/hive_flutter.dart' show Hive;
import 'package:secure_storage/secure_storage.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(() async {
    // const defaultBaseUrl = 'http://192.168.0.161:3000';
    const defaultBaseUrl = 'http://192.168.0.100:3000';

    // const defaultBaseUrl = 'http://95.85.117.102:8545';

    const secureStorage = SecureStorage();
    const settingsStorage = SettingsStorage(storage: secureStorage);

    final httpClient = Http(
      defaultBaseUrl: defaultBaseUrl,
    );
    await settingsStorage.setAppBaseUrl(
        (await settingsStorage.fetchAppBaseUrl()) ?? defaultBaseUrl);
    HttpOverrides.global = MyHttpOverrides();

    const permissionClient = PermissionClient();
    await permissionClient.init();
    final storageRepository =
        StorageRepository(permissionClient: permissionClient);
    final settingsClient = SettingsClient(httpClient: httpClient);
    final settingsRepository = SettingsRepository(
      defaultBaseUrl: defaultBaseUrl,
      settingsClient: settingsClient,
      settingsStorage: settingsStorage,
    );
 

    final userReportsBox =
        await Hive.openBox<List<OrderMap>>(HiveBoxKeys.userReportsBoxKey);

    ///Network client for the reports
    final reportsClient = ReportsClient(httpClient: httpClient);

    final reportsRepository = ReportsRepository(reportsClient: reportsClient);

    ///Box client for the reports

    final reportBoxClient = ReportBoxClient(reportsBox: userReportsBox);

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
      settingsRepository: settingsRepository,
      reportsRepository: reportsRepository,
      storageRepository: storageRepository,
      reportBoxClient: reportBoxClient,
      ordersRepository: ordersRepository,
      authRepository: authRepository,
      userRepository: userRepository,
      operationRepository: operationRepository,
      employeesRepository: employeesRepository,
    );
  });
}
