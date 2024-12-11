import 'package:data_provider/data_provider.dart';

class EmployeesClient {
  const EmployeesClient({
    required Http httpClient,
  }) : _http = httpClient;

  final Http _http;

  Future<List<EmployeesItem>?> getEmployees() async {
    try {
      final response = await _http.get<List<dynamic>>('/employees');

      final employeesList = response.data!.map((e) => e as JsonType).toList();
      return employeesList.map(EmployeesItem.fromJson).toList();
    } 
    // on DioException catch (_) {
    //   final employees = await getJsonList(
    //     'packages/data_provider/assets/local_employees.json',
    //   );
    //   if (employees != null) {
    //     return employees
    //         .map((e) => e as JsonType)
    //         .toList()
    //         .map(EmployeesItem.fromJson)
    //         .toList();
    //   } else {
    //     throw Exception('Failed to load local employees data.');
    //   }
    // } 
    catch (error) {
      throw Exception('Error fetching employees: $error');
    }
  }
}
