import 'package:data_provider/data_provider.dart';
import 'package:dio/dio.dart';

class OperationClient {
  const OperationClient({
    required Http httpClient,
  }) : _http = httpClient;

  final Http _http;

  Future<List<OperationItem>?> getOperations([String? search]) async {
    try {
      final response = await _http.get<List<dynamic>>('/type_oper');

      final operationsList = response.data!.map((e) => e as JsonType).toList();
      return operationsList.map(OperationItem.fromJson).toList();
    } 
    on DioException catch (_) {
      final operations = await getJsonList(
        'packages/data_provider/assets/local_operations.json',
      );
      if (operations != null) {
        return operations
            .map((e) => e as JsonType)
            .toList()
            .map(OperationItem.fromJson)
            .toList();
      } else {
        throw Exception('Failed to load local operations data.');
      }
    } 
    catch (error) {
      throw Exception('Error fetching operations: $error');
    }
  }
}
