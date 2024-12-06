part of 'reports_network_bloc.dart';

sealed class ReportsNetworkEvent extends Equatable {
  const ReportsNetworkEvent();

  @override
  List<Object> get props => [];
}


final class ReportsNetworkRequested extends ReportsNetworkEvent {}
