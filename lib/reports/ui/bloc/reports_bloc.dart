import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportBoxEvent, ReportsState> {
  ReportsBloc({
    required ReportBoxClient reportsBox,
    required ReportsRepository reportsRepository,
  })  : _reportsRepository = reportsRepository,
        _reportsBox = reportsBox,
        super(const ReportsState.initial()) {
    on<ReportOrdersRequested>(_onReportOrdersRequested);
    on<ReportOrderAdded>(_onReportOrderAdded);
    on<ReportOrderRemoved>(_onReportOrderRemoved);
    on<ReportOperationsRequested>(_onReportOperationsRequested);
    on<ReportOperationAdded>(_onReportOperationAdded);
    on<ReportOperationRemoved>(_onReportOperationRemoved);
    on<ReportsSendRequested>(_onSendReportsRequested);
    on<ReportsCleared>(_onReportsCleared);
  }

  final ReportBoxClient _reportsBox;
  final ReportsRepository _reportsRepository;

  // Fetch orders for the given employee
  Future<void> _onReportOrdersRequested(
    ReportOrdersRequested event,
    Emitter<ReportsState> emit,
  ) async {
    log('_onReportOrdersRequested event stateFetching : ${state.isFetching}');

    emit(state.copyWith(status: ReportsStatus.loading));

    try {
      final orders = await _reportsBox.getOrders(employee: event.employee);
      emit(state.copyWith(
        status: ReportsStatus.success,
        orders: orders,
      ));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }

  Future<void> _onReportOrderAdded(
    ReportOrderAdded event,
    Emitter<ReportsState> emit,
  ) async {
    log('_onReportOrderAdded event stateFetching : ${state.isFetching}');

    emit(state.copyWith(status: ReportsStatus.loading));

    try {
      await _reportsBox.addOrder(employee: event.employee, order: event.order);
      emit(state.copyWith(status: ReportsStatus.success));
      add(ReportOrdersRequested(employee: event.employee));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }

  Future<void> _onReportOperationsRequested(
    ReportOperationsRequested event,
    Emitter<ReportsState> emit,
  ) async {
    log('_onReportOperationsRequested event stateFetching : ${state.isFetching}');
    //if (state.isFetching) return;

    emit(state.copyWith(status: ReportsStatus.loading));

    try {
      final operations = await _reportsBox.getOperations(
        employee: event.employee,
        order: event.order,
      );

      emit(
        state.copyWith(
          status: ReportsStatus.success,
          operations: operations,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }

  // Add an operation to the order and refresh operations
  Future<void> _onReportOperationAdded(
    ReportOperationAdded event,
    Emitter<ReportsState> emit,
  ) async {
    log('_onReportOperationAdded event stateFetching : ${state.isFetching}');
    //if (state.isFetching) return;

    emit(state.copyWith(status: ReportsStatus.loading));

    try {
      await _reportsBox.addOperation(
        employee: event.employee,
        order: event.order,
        operation: event.operation,
        quantity: event.quantity,
      );

      emit(state.copyWith(status: ReportsStatus.success));
      add(
        ReportOperationsRequested(
          employee: event.employee,
          order: event.order,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }

  // Clear all reports
  Future<void> _onReportsCleared(
    ReportsCleared event,
    Emitter<ReportsState> emit,
  ) async {
    //if (state.isFetching) return; // Prevent redundant calls

    emit(state.copyWith(status: ReportsStatus.loading));

    try {
      _reportsBox.clearAllReports();
      emit(state.copyWith(status: ReportsStatus.success, isFetching: false));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }

  FutureOr<void> _onSendReportsRequested(
    ReportsSendRequested event,
    Emitter<ReportsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ReportsStatus.loading));
      final reports = await _reportsBox.sendReportItems(
        employees: event.employeesFull,
        orders: event.ordersFull,
        operations: event.operationsFull,
      );
      log('Reports: $reports');
      await _reportsRepository.sendReports(reports);
      emit(state.copyWith(status: ReportsStatus.success, reports: reports));
      add(const ReportsCleared());
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }

  FutureOr<void> _onReportOperationRemoved(
    ReportOperationRemoved event,
    Emitter<ReportsState> emit,
  ) async {
    //if (state.isFetching) return;

    emit(state.copyWith(status: ReportsStatus.loading));

    try {
      await _reportsBox.removeOperation(
        employee: event.employee,
        order: event.order,
        operation: event.operation,
      );

      emit(state.copyWith(status: ReportsStatus.success));
      add(
        ReportOperationsRequested(
          employee: event.employee,
          order: event.order,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }

  FutureOr<void> _onReportOrderRemoved(
    ReportOrderRemoved event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(status: ReportsStatus.loading));

    try {
      await _reportsBox.removeOrder(
        employee: event.employee,
        order: event.order,
      );

      emit(state.copyWith(status: ReportsStatus.success));
      add(ReportOrdersRequested(employee: event.employee));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }
}
