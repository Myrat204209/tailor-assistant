part of 'operation_bloc.dart';

enum OperationStatus { initial, loading, success, failure }

final class OperationState extends Equatable {
  const OperationState({
    required this.status,
    this.operations = const [],
    this.search,
  });
  const OperationState.initial() : this(status: OperationStatus.initial);

  final OperationStatus status;
  final List<OperationItem> operations;
  final String? search;
  @override
  List<Object?> get props => [status, operations, search];

  OperationState copyWith({
    OperationStatus? status,
    List<OperationItem>? operations,
    String? search,
  }) {
    return OperationState(
      status: status ?? this.status,
      operations: operations ?? this.operations,
      search: search ?? this.search,
    );
  }
}
