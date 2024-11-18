import 'package:data_provider/data_provider.dart';

class EmployeesClient {
  const EmployeesClient({
    required Http httpClient,
  }) : _http = httpClient;

  final Http _http;

  Future<List<EmployeesItem>?> getEmployees() async {
    final response = await _http.get<List<JsonType>>('/employees');

    return response.data!.map(EmployeesItem.fromJson).toList();
  }
}
