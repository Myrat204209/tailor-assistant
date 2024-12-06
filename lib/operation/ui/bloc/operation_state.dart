part of 'operation_bloc.dart';

enum OperationStatus { initial, loading, success, failure }

final class OperationState extends Equatable {
  const OperationState({
    required this.status,
    this.isFetching = false,
    this.operations = const [],
  });
  const OperationState.initial() : this(status: OperationStatus.initial);

  final OperationStatus status;
  final bool isFetching;
  final List<OperationItem> operations;
  @override
  List<Object?> get props => [status, operations, isFetching];

  OperationState copyWith({
    OperationStatus? status,
    List<OperationItem>? operations,
    bool? isFetching,
  }) {
    return OperationState(
      status: status ?? this.status,
      operations: operations ?? this.operations,
      isFetching: isFetching ?? this.isFetching,
    );
  }
}
