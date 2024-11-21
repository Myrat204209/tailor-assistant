import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

abstract class OperationFailure with EquatableMixin implements Exception {
  const OperationFailure(this.error);
  final Object error;

  @override
  List<Object?> get props => [error];
}

class GetOperationListFailure extends OperationFailure {
  GetOperationListFailure(super.error);
}

class OperationRepository {
  OperationRepository({
    required OperationClient operationClient,
  }) : _operationClient = operationClient;

  final OperationClient _operationClient;

  Future<List<OperationItem>?> getOperations() async {
    try {
      return await _operationClient.getOperations();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetOperationListFailure(error), stackTrace);
    }
  }
}
