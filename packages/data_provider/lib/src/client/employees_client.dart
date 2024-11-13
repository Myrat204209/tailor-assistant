// import 'package:data_provider/data_provider.dart';

// class EmployeesClient {
//   const EmployeesClient({
//     required Http httpClient,
//   }) : _http = httpClient;

//   final Http _http;

//   Future<List<EmployeesItem>> getEmployeess() async {
//     final response = await _http.get<List<dynamic>>('/Employeess');
//     final List<EmployeesItem>? Employeess;

//     Employeess =
//         response.data!.map((Employees) => EmployeesItem.fromJson(Employees)).toList();

//     return Employeess;
//   }
// }
