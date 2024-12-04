// import 'package:data_provider/data_provider.dart'; // Assuming you have this package for Http and local storage
// import 'package:equatable/equatable.dart';

// /// A base failure for the reports repository failures
// abstract class ReportFailure with EquatableMixin implements Exception {
//   const ReportFailure(this.error);

//   /// The error which was caught.
//   final Object error;

//   @override
//   List<Object> get props => [error];
// }

// class GetReportsFailure extends ReportFailure {
//   const GetReportsFailure(super.error);
// }

// class SendReportsFailure extends ReportFailure {
//   const SendReportsFailure(super.error);
// }

// class UpdateReportFailure extends ReportFailure {
//   const UpdateReportFailure(super.error);
// }

// class DeleteReportFailure extends ReportFailure {
//   const DeleteReportFailure(super.error);
// }

// class ReportsRepository {
//   const ReportsRepository({
//     required ReportsClient reportsClient,
//   }) : _reportsClient = reportsClient;

//   final ReportsClient _reportsClient;

//   /// Remote method to get all reports
//   Future<List<ReportItem>?> getReports() async {
//     try {
//       return await _reportsClient.getReports();
//     } catch (error, stackTrace) {
//       Error.throwWithStackTrace(GetReportsFailure(error), stackTrace);
//     }
//   }

//   /// Remote method to send a list of reports
//   Future<List<ReportItem>?> sendReports(List<ReportItem> reports) async {
//     try {
//       return await _reportsClient.sendReports(reports: reports);
//     } catch (error, stackTrace) {
//       Error.throwWithStackTrace(SendReportsFailure(error), stackTrace);
//     }
//   }

//   /// Remote method to update a report by its ID
//   Future<ReportItem?> updateReport({
//     required int id,
//     required ReportItem report,
//   }) async {
//     try {
//       return await _reportsClient.updateReport(id: id, report: report);
//     } catch (error, stackTrace) {
//       Error.throwWithStackTrace(UpdateReportFailure(error), stackTrace);
//     }
//   }

//   /// Remote method to delete a report by its ID
//   Future<bool> deleteReport({required int id}) async {
//     try {
//       return await _reportsClient.deleteReport(id: id);
//     } catch (error, stackTrace) {
//       Error.throwWithStackTrace(DeleteReportFailure(error), stackTrace);
//     }
//   }
// }
