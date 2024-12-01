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
    on<ReportEmployeeSelected>(_onEmployeeSelected);
    on<ReportProductSelected>(_onProductSelected);
    on<ReportsRequested>(_onRequested);
    on<ReportsSendRequested>(_onSendRequested);
    on<ReportUpdateRequested>(_onUpdateRequested);
    on<ReportDeleteRequested>(_onDeleteRequested);
    on<ReportOperationSelected>(_onOperationSelected); // Added
    on<ReportQuantityAdded>(_onQuantityAdded); // Added
    on<ReportSaved>(_onSaveReport); // Added
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
    try {
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

  FutureOr<void> _onEmployeeSelected(
    ReportEmployeeSelected event,
    Emitter<ReportsState> emit,
  ) async {
    final newReports = state.reports.isEmpty
        ? [
            ReportItem(
              employeeCode: event.employeeCode,
              employeeName: event.employeeName,
              itemCode: '',
              itemName: '',
              docNumber: '',
              workCode: '',
              workName: '',
              workQuantity: 0,
              comments: '',
            ),
          ]
        : state.reports.map((item) {
            return ReportItem.copy(item)
              ..employeeCode = event.employeeCode
              ..employeeName = event.employeeName;
          }).toList();

    emit(state.copyWith(reports: newReports));
  }

  // Event handler for OperationSelected
  Future<void> _onOperationSelected(
    ReportOperationSelected event,
    Emitter<ReportsState> emit,
  ) async {
    final updatedReportItems = state.reports.map((item) {
      if (item.workCode!.isEmpty) {
        return ReportItem.copy(item)
          ..workCode = event.operation.workCode
          ..workName = event.operation.workName;
      }
      return item;
    }).toList();

    emit(state.copyWith(reports: updatedReportItems));
  }

  // Event handler for QuantityAdded
  Future<void> _onQuantityAdded(
    ReportQuantityAdded event,
    Emitter<ReportsState> emit,
  ) async {
    final updatedReportItems = state.reports.map((item) {
      if (item.workCode == event.workCode) {
        return ReportItem.copy(item)..workQuantity = event.quantity;
      }
      return item;
    }).toList();

    emit(state.copyWith(reports: updatedReportItems));
  }

  // Event handler for SaveReport (this could save the report to an API, etc.)
  Future<void> _onSaveReport(
    ReportSaved event,
    Emitter<ReportsState> emit,
  ) async {
    // Here you would handle the logic
    //for saving the report, e.g. to a repository or API.
    // After saving, you could reset the report state or keep it as needed.
    print('Saving report: ${state.reports}');
    // Example: Reset the reports after saving (optional)
    emit(state.copyWith(reports: []));
  }

  FutureOr<void> _onProductSelected(
    ReportProductSelected event,
    Emitter<ReportsState> emit,
  ) async {
    final updatedReports = state.reports.map((item) {
      if (item.itemCode!.isEmpty) {
        return ReportItem.copy(item)
          ..itemCode = event.product.itemCode
          ..itemName = event.product.itemName
          ..docNumber = event.product.docNumber;
      }
      return item;
    }).toList();

    if (updatedReports.every((item) => item.isNotEmpty)) {
      updatedReports.add(
        ReportItem(
          employeeCode: state.reports[0].employeeCode,
          employeeName: state.reports[0].employeeName,
          itemCode: event.product.itemCode,
          itemName: event.product.itemName,
          docNumber: event.product.docNumber,
          workCode: '',
          workName: '',
          workQuantity: 0,
          comments: '',
        ),
      );
    }

    emit(state.copyWith(reports: updatedReports));
  }
}
