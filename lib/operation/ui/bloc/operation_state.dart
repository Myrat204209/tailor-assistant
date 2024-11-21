part of 'operation_bloc.dart';

enum OperationStatus { initial, loading, success, failure }

final class OperationState extends Equatable {
  const OperationState({
    required this.status,
    this.operations = const [],
  });
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
}
