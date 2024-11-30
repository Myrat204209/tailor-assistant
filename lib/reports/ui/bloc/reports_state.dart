part of 'reports_bloc.dart';

enum ReportsStatus { initial, loading, success, failure }

final class ReportsState extends Equatable {
  const ReportsState({
    required this.status,
    this.reports = const [],
  });

  const ReportsState.initial() : this(status: ReportsStatus.initial);

  final ReportsStatus status;
  final List<ReportItem> reports;

  @override
  List<Object?> get props => [status, reports];

  ReportsState copyWith({
    ReportsStatus? status,
    List<ReportItem>? reports,
  }) {
    return ReportsState(
      status: status ?? this.status,
      reports: reports ?? this.reports,
    );
  }
}
