part of 'operation_bloc.dart';

sealed class OperationEvent extends Equatable {
  const OperationEvent();

  @override
  List<Object> get props => [];
}

final class OperationRequested extends OperationEvent {
  const OperationRequested();
}
final class OperationRefreshRequested extends OperationEvent {}
final class OperationSearchUpdated extends OperationEvent {
  const OperationSearchUpdated(this.search);
  final String search;

  @override
  List<Object> get props => [search];
}
