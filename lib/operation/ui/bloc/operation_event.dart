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
