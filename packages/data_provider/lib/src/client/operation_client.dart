import 'package:data_provider/data_provider.dart';

class OperationClient {
  const OperationClient({
    required Http http,
  }) : _http = http;

  final Http _http;

  Future<List<OperationItem>?> getOperations([String? search]) async {
    final response = await _http.get<List<dynamic>>('/type_oper');
    final operationsList = (response.data!).map((e) => e as JsonType).toList();
    return operationsList.map(OperationItem.fromJson).toList();
  }
}
