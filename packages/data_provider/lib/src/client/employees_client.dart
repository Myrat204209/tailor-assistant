

import 'package:data_provider/data_provider.dart';

class EmployeesClient {
  const EmployeesClient({
    required Http httpClient,
  }) : _http = httpClient;

  final Http _http;

  Future<List<EmployeesItem>?> getEmployees() async {
    final response = await _http.get<List<dynamic>>('/employees');
    
    final employeesList =
        (response.data!).map((e) => e as JsonType).toList();

    return employeesList.map(EmployeesItem.fromJson).toList();
  }
}
