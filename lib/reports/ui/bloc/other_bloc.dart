// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'report_event.dart';
// part 'report_state.dart';

// class ReportBloc extends Bloc<ReportEvent, ReportState> {
//   ReportBloc() : super(const ReportState.initial()) {
//     // Register event handlers
//     on<EmployeeSelected>(_onEmployeeSelected);
//     on<ProductSelected>(_onProductSelected);
//     on<OperationSelected>(_onOperationSelected);
//     on<QuantityAdded>(_onQuantityAdded);
//     on<SaveReport>(_onSaveReport);
//   }

//   // Event handler for EmployeeSelected
//   Future<void> _onEmployeeSelected(
//     EmployeeSelected event,
//     Emitter<ReportState> emit,
//   ) async {
//     final newReportItems = state.reportItems.isEmpty
//         ? [
//             ReportItem(
//               employeeCode: event.employeeCode,
//               employeeName: event.employeeName,
//               itemCode: '',
//               itemName: '',
//               docNumber: '',
//               workCode: '',
//               workName: '',
//               workQuantity: 0,
//               comments: '',
//               quantity: 0,
//               workPrice: '',
//             )
//           ]
//         : state.reportItems.map((item) {
//             return ReportItem.copy(item)
//               ..employeeCode = event.employeeCode
//               ..employeeName = event.employeeName;
//           }).toList();

//     emit(state.copyWith(reportItems: newReportItems));
//   }

//   // Event handler for ProductSelected
//   Future<void> _onProductSelected(
//     ProductSelected event,
//     Emitter<ReportState> emit,
//   ) async {
//     final updatedReportItems = state.reportItems.map((item) {
//       if (item.itemCode.isEmpty) {
//         return ReportItem.copy(item)
//           ..itemCode = event.product.itemCode
//           ..itemName = event.product.itemName
//           ..docNumber = event.product.docNumber;
//       }
//       return item;
//     }).toList();

//     if (updatedReportItems.every((item) => item.itemCode.isNotEmpty)) {
//       updatedReportItems.add(ReportItem(
//         employeeCode: state.reportItems[0].employeeCode,
//         employeeName: state.reportItems[0].employeeName,
//         itemCode: event.product.itemCode,
//         itemName: event.product.itemName,
//         docNumber: event.product.docNumber,
//         workCode: '',
//         workName: '',
//         workQuantity: 0,
//         comments: '',
//         quantity: 0,
//         workPrice: '',
//       ));
//     }

//     emit(state.copyWith(reportItems: updatedReportItems));
//   }

//   // Event handler for OperationSelected
//   Future<void> _onOperationSelected(
//     OperationSelected event,
//     Emitter<ReportState> emit,
//   ) async {
//     final updatedReportItems = state.reportItems.map((item) {
//       if (item.workCode.isEmpty) {
//         return ReportItem.copy(item)
//           ..workCode = event.operation.workCode
//           ..workName = event.operation.workName
//           ..workPrice = event.operation.workPrice;
//       }
//       return item;
//     }).toList();

//     emit(state.copyWith(reportItems: updatedReportItems));
//   }

//   // Event handler for QuantityAdded
//   Future<void> _onQuantityAdded(
//     QuantityAdded event,
//     Emitter<ReportState> emit,
//   ) async {
//     final updatedReportItems = state.reportItems.map((item) {
//       if (item.workCode == event.workCode) {
//         return ReportItem.copy(item)..quantity = event.quantity;
//       }
//       return item;
//     }).toList();

//     emit(state.copyWith(reportItems: updatedReportItems));
//   }

//   // Event handler for SaveReport (this could save the report to an API, etc.)
//   Future<void> _onSaveReport(
//     SaveReport event,
//     Emitter<ReportState> emit,
//   ) async {
//     // Here you would handle the logic for saving the report, e.g. to a repository or API.
//     // After saving, you could reset the report state or keep it as needed.
//     print("Saving report: ${state.reportItems}");
//     emit(state.copyWith(reportItems: [])); // Resetting the report items after saving (optional)
//   }
// }
