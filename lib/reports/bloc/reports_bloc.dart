import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportEvent, ReportsState> {
  ReportsBloc({required this.reportsRepository})
      : super(const ReportsState.initial()) {
    on<ReportsRequested>(_onRequested);
    on<ReportsSendRequested>(_onSendRequested);
    on<ReportUpdateRequested>(_onUpdateRequested);
    on<ReportDeleteRequested>(_onDeleteRequested);
  }
  final ReportsRepository reportsRepository;

  bool _isFetching = false;

  FutureOr<void> _onRequested(
    ReportsRequested event,
    Emitter<ReportsState> emit,
  ) async {
    if (_isFetching) return;
    _isFetching = true;
    try {
      emit(state.copyWith(status: ReportsStatus.loading));
      final reports = await reportsRepository.getReports();
      emit(
        state.copyWith(
          status: ReportsStatus.success,
          reports: reports ?? [],
        ),
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ReportsStatus.failure));
      addError(error, stackTrace);
    } finally {
      _isFetching = false;
    }
  }

  FutureOr<void> _onSendRequested(
    ReportsSendRequested event,
    Emitter<ReportsState> emit,
  ) async {
    if (_isFetching) return;
    _isFetching = true;
    try {
      emit(state.copyWith(status: ReportsStatus.loading));
      await reportsRepository.sendReports(event.reports);
      emit(
        state.copyWith(
          status: ReportsStatus.success,
        ),
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ReportsStatus.failure));
      addError(error, stackTrace);
    } finally {
      _isFetching = false;
    }
  }

  FutureOr<void> _onUpdateRequested(
    ReportUpdateRequested event,
    Emitter<ReportsState> emit,
  ) async {
    if (_isFetching) return;
    _isFetching = true;
    try {
      emit(state.copyWith(status: ReportsStatus.loading));
      await reportsRepository.updateReport(
        id: event.id,
        report: event.report,
      );
      emit(
        state.copyWith(
          status: ReportsStatus.success,
        ),
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ReportsStatus.failure));
      addError(error, stackTrace);
    } finally {
      _isFetching = false;
    }
  }

  FutureOr<void> _onDeleteRequested(
    ReportDeleteRequested event,
    Emitter<ReportsState> emit,
  ) async {
    if (_isFetching) return;
    _isFetching = true;
    try {
      emit(state.copyWith(status: ReportsStatus.loading));
      final success = await reportsRepository.deleteReport(id: event.id);
      if (success) {
        emit(
          state.copyWith(
            status: ReportsStatus.success,
            reports:
                state.reports.where((report) => report.id != event.id).toList(),
          ),
        );
      } else {
        emit(state.copyWith(status: ReportsStatus.failure));
      }
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ReportsStatus.failure));
      addError(error, stackTrace);
    } finally {
      _isFetching = false;
    }
  }
}
