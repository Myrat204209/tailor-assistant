import 'package:data_provider/data_provider.dart';

class OperationClient {
  const OperationClient({
    required Http http,
  }) : _http = http;

  final Http _http;

  Future<List<OperationItem>?> getOperations() async {
    final response = await _http.get<List<JsonType>>('/operations');

    return response.data!.map(OperationItem.fromJson).toList();
  }
}
