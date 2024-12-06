part of 'reports_network_bloc.dart';

enum ReportsNetworkStatus { initial, loading, success, failure }

class ReportsNetworkState extends Equatable {
  const ReportsNetworkState({
    required this.status,
    this.reports = const [],
  });

  const ReportsNetworkState.initial()
      : this(status: ReportsNetworkStatus.initial);

  final ReportsNetworkStatus status;
  final List<ReportItem> reports;

  @override
  List<Object> get props => [status, reports];

  ReportsNetworkState copyWith({
    ReportsNetworkStatus? status,
    List<ReportItem>? reports,
  }) {
    return ReportsNetworkState(
      status: status ?? this.status,
      reports: reports ?? this.reports,
    );
  }
}
