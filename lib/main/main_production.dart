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

/// The entry point of the application.
///
/// This function initializes the HTTP client and the Hive database, and
/// then creates the application's repositories and the application itself.
void main() {
  bootstrap(() {
    /// The base URL of the API.
    ///
    /// This URL is used by the HTTP client to make requests to the API.
    const defaultBaseUrl = 'http://192.168.0.161:3000';

    /// The HTTP client.
    ///
    /// This client is used to make requests to the API.
    final httpClient = Http(
      defaultBaseUrl: defaultBaseUrl,
    );

    /// The HTTP overrides.
    ///
    /// This is used to override the default HTTP client of the application.
    HttpOverrides.global = MyHttpOverrides();

    /// The permission client.
    ///
    /// This client is used to request permissions from the user.
    const permissionClient = PermissionClient();

    /// The storage repository.
    ///
    /// This repository is used to store data in the device's storage.
    final storageRepository =
        StorageRepository(permissionClient: permissionClient);

    /// The Hive adapters.
    ///
    /// These adapters are used to store custom objects in the Hive database.
    Hive.registerAdapter(EmployeesItemAdapter());

    Hive.registerAdapter(OperationItemAdapter());

    Hive.registerAdapter(OrderItemAdapter());


    /// The user reports box.
    /// This box is used to store the user's reports.
    final userReportsBox =
        Hive.openBox<EmployeesMap>(HiveBoxKeys.userReportsBoxKey);

    /// The reports client.
    ///
    /// This client is used to make requests to the reports API.
    final reportsClient = ReportsClient(httpClient: httpClient);

    /// The reports repository.
    ///
    /// This repository is used to store reports.
    final reportsRepository = ReportsRepository(reportsClient: reportsClient);

    /// The employees client.
    ///
    /// This client is used to make requests to the employees API.
    final employeesClient = EmployeesClient(httpClient: httpClient);

    /// The employees repository.
    ///
    /// This repository is used to store employees.
    final employeesRepository =
        EmployeesRepository(employeesClient: employeesClient);

    /// The operation client.
    ///
    /// This client is used to make requests to the operation API.
    final operationClient = OperationClient(http: httpClient);

    /// The orders client.
    ///
    /// This client is used to make requests to the orders API.
    final ordersClient = OrderClient(http: httpClient);

    /// The orders repository.
    ///
    /// This repository is used to store orders.
    final ordersRepository = OrdersRepository(orderClient: ordersClient);

    /// The operation repository.
    ///
    /// This repository is used to store operations.
    final operationRepository =
        OperationRepository(operationClient: operationClient);

    /// The authentication repository.
    ///
    /// This repository is used to authenticate users.
    final authRepository = AuthRepository();

    /// The user repository.
    ///
    /// This repository is used to store users.
    final userRepository = UserRepository();

    /// The application.
    ///
    /// This is the main widget of the application.
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
