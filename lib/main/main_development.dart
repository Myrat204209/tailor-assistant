import 'dart:io';

import 'package:auth_repository/auth_repository.dart';
import 'package:dap_foreman_assis/app/app.dart';
import 'package:dap_foreman_assis/employees/data/data.dart';
import 'package:dap_foreman_assis/main/bootstrap/bootstrap.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:data_provider/data_provider.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(() {
    /// Constants
    const defaultBaseUrl = 'http://192.168.0.161:3000';

    /// HTTP Client
    final httpClient = Http(
      defaultBaseUrl: defaultBaseUrl,
      enableLogger: false,
    );

    /// Only for development
    HttpOverrides.global = MyHttpOverrides();
    final employeesClient = EmployeesClient(httpClient: httpClient);
    final employeesRepository =
        EmployeesRepository(employeesClient: employeesClient);
    final operationClient = OperationClient(http: httpClient);
    final ordersClient = OrderClient(http: httpClient);
    final ordersRepository = OrdersRepository(orderClient: ordersClient);
    final operationRepository =
        OperationRepository(operationClient: operationClient);
    final authRepository = AuthRepository();
    final userRepository = UserRepository();
    return App(
      ordersRepository: ordersRepository,
      authRepository: authRepository,
      userRepository: userRepository,
      operationRepository: operationRepository,
      employeesRepository: employeesRepository,
    );
  });
}
