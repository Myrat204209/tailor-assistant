part of 'operation_bloc.dart';

enum OperationStatus { initial, loading, success, failure }

final class OperationState extends Equatable {
  const OperationState({
    required this.status,
    this.operations = const [],
  });

  factory OperationState.fromJson(Map<String, dynamic> json) {
    return OperationState(
      status: OperationStatus.values[json['status'] as int],
      operations: (json['operations'] as List<dynamic>)
          .map((operationJson) =>
              OperationItem.fromJson(operationJson as Map<String, dynamic>))
          .toList(),
    );
  }
  const OperationState.initial() : this(status: OperationStatus.initial);

  final OperationStatus status;
  final List<OperationItem> operations;

  @override
  List<Object?> get props => [status, operations];

  OperationState copyWith({
    OperationStatus? status,
    List<OperationItem>? operations,
  }) {
    return OperationState(
      status: status ?? this.status,
      operations: operations ?? this.operations,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.index,
      'operations': operations.map((operation) => operation.toJson()).toList(),
    };
  }
}
