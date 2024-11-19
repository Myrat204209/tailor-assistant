import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeesFailure with EquatableMixin implements Exception {
  const EmployeesFailure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}

class GetEmployeesListFailure extends EmployeesFailure {
  GetEmployeesListFailure(super.error);
}

class EmployeesRepository {
  const EmployeesRepository({
    required EmployeesClient employeesClient,
  }) : _employeesClient = employeesClient;

  final EmployeesClient _employeesClient;

  Future<List<EmployeesItem>?> getEmployees() async {
    try {
      return await _employeesClient.getEmployees();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetEmployeesListFailure(error), stackTrace);
    }
  }
}
