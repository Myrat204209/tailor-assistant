import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

part 'reports_network_event.dart';
part 'reports_network_state.dart';

class ReportsNetworkBloc
    extends Bloc<ReportsNetworkEvent, ReportsNetworkState> {
  ReportsNetworkBloc({required ReportsRepository reportsRepository})
      : _reportsRepository = reportsRepository,
        super(const ReportsNetworkState.initial()) {
    on<ReportsNetworkRequested>(_onRequested);
  }

  final ReportsRepository _reportsRepository;

  FutureOr<void> _onRequested(
    ReportsNetworkRequested event,
    Emitter<ReportsNetworkState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ReportsNetworkStatus.loading));
      final reports = await _reportsRepository.getReports();
      emit(
        state.copyWith(
          status: ReportsNetworkStatus.success,
          reports: reports ?? [],
        ),
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ReportsNetworkStatus.failure));
      addError(error, stackTrace);
    }
  }
}
