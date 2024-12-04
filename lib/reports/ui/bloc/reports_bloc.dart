import 'package:bloc/bloc.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

part 'reports_event.dart';
part 'reports_state.dart';

final class ReportsBloc extends Bloc<ReportBoxEvent, ReportsState> {
  ReportsBloc({required ReportsRepository reportsRepository})
      : _reportsRepository = reportsRepository,
        super(const ReportsState.initial()) {
    on<ReportEmployeeAdded>(_onReportEmployeeAdded);
    on<ReportOrdersRequested>(_onReportOrdersRequested);
    on<ReportOrderAdded>(_onReportOrderAdded);
    on<ReportOperationsRequested>(_onReportOperationsRequested);
    on<ReportOperationAdded>(_onReportOperationAdded);
    on<ReportsCleared>(_onReportsCleared);
  }

  final ReportsRepository _reportsRepository;

  // Add an employee and trigger the fetching of orders
  Future<void> _onReportEmployeeAdded(
    ReportEmployeeAdded event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(status: ReportsStatus.loading));
    try {
      await _reportsRepository.addEmployee(event.employee);
      emit(
        state.copyWith(
          status: ReportsStatus.success,
          employee: event.employee,
        ),
      );
      // After adding employee, fetch their orders
      add(ReportOrdersRequested(event.employee));
    } catch (error) {
      addError(error);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }

  // Fetch orders for the given employee
  Future<void> _onReportOrdersRequested(
    ReportOrdersRequested event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(status: ReportsStatus.loading));
    try {
      final orders = await _reportsRepository.getOrders(event.employee);
      emit(state.copyWith(status: ReportsStatus.success, orders: orders));
    } catch (error) {
      addError(error);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }

  // Add a new order for the employee and refresh orders
  Future<void> _onReportOrderAdded(
    ReportOrderAdded event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(status: ReportsStatus.loading));
    try {
      await _reportsRepository.addOrder(event.employee, event.order);
      emit(state.copyWith(status: ReportsStatus.success));
      // After adding the order, trigger a refresh of orders
      add(ReportOrdersRequested(event.employee));
    } catch (error) {
      addError(error);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }

  // Fetch operations for the given employee and order
  Future<void> _onReportOperationsRequested(
    ReportOperationsRequested event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(status: ReportsStatus.loading));
    try {
      final operations =
          await _reportsRepository.getOperations(event.employee, event.order);
      emit(
        state.copyWith(
          status: ReportsStatus.success,
          operations: operations,
        ),
      );
    } catch (error) {
      addError(error);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }

  // Add an operation to the order and refresh operations
  Future<void> _onReportOperationAdded(
    ReportOperationAdded event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(status: ReportsStatus.loading));
    try {
      await _reportsRepository.addOperation(
        event.employee,
        event.order,
        event.operation,
        event.quantity,
      );
      emit(state.copyWith(status: ReportsStatus.success));
      // After adding the operation, refresh operations
      add(ReportOperationsRequested(event.employee, event.order));
    } catch (error) {
      addError(error);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }

  // Clear all reports
  Future<void> _onReportsCleared(
    ReportsCleared event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(status: ReportsStatus.loading));
    try {
      _reportsRepository.clearAllReports();
      emit(state.copyWith(status: ReportsStatus.success));
    } catch (error) {
      addError(error);
      emit(state.copyWith(status: ReportsStatus.failure));
    }
  }
}
