import 'package:data_provider/data_provider.dart';

class ReportsClient {
  const ReportsClient({
    required Http httpClient,
  }) : _http = httpClient;

  final Http _http;
  Future<List<ReportItem>?> getReports() async {
    final response = await _http.get<List<dynamic>>(
      '/reports',
    );

    final reportsList = (response.data!).map((e) => e as JsonType).toList();
    return reportsList.map(ReportItem.fromJson).toList();
  }

  Future<List<ReportItem>?> sendReports({
    required List<ReportItem> reports,
  }) async {
    final response = await _http.post<List<dynamic>>(
      '/reports',
      data: reports.map((report) => report.toJson()).toList(),
    );

    final reportsList = (response.data!).map((e) => e as JsonType).toList();
    return reportsList.map(ReportItem.fromJson).toList();
  }

  Future<ReportItem?> updateReport({
    required int id,
    required ReportItem report,
  }) async {
    final response = await _http.put<JsonType>(
      '/reports/$id',
      data: report.toJson(),
    );

    return ReportItem.fromJson(response.data!);
  }

  Future<bool> deleteReport({required int id}) async {
    final response = await _http.delete<JsonType>('/reports/$id');
    return response.statusCode == 200;
  }
}
