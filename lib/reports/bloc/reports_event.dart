part of 'reports_bloc.dart';

sealed class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

final class ReportsRequested extends ReportEvent {
  const ReportsRequested();
}

final class ReportsSendRequested extends ReportEvent {
  const ReportsSendRequested(this.reports);
  final List<ReportItem> reports;

  @override
  List<Object> get props => [reports];
}

final class ReportUpdateRequested extends ReportEvent {
  const ReportUpdateRequested(this.id, this.report);
  final int id;
  final ReportItem report;

  @override
  List<Object> get props => [id, report];
}

final class ReportDeleteRequested extends ReportEvent {
  const ReportDeleteRequested(this.id);
  final int id;

  @override
  List<Object> get props => [id];
}

final class ReportRefreshRequested extends ReportEvent {}
