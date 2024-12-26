import 'package:hive_ce/hive.dart';

typedef UserReportsBox = Box<List<dynamic>>;

/// Hive box keys for the [Hive].
abstract class HiveBoxKeys {
  /// User addresses.
  static const String userReportsBoxKey = '__user_reports_key__';
}

// OperationMapAdapter
class OperationMap extends HiveObject {
  OperationMap({required this.key, required this.value});

  @override
  final String key; // Corresponds to workCode

  int value; // Quantity, mutable to allow updates

  @override
  String toString() => 'OperationMap(key: $key, value: $value)';
}

// OrderMapAdapter
class OrderMap extends HiveObject {
  OrderMap({required this.key, required this.operationMaps});

  @override
  final String key; // Corresponds to docNumber

  List<OperationMap> operationMaps;

  @override
  String toString() => 'OrderMap(key: $key, operations: $operationMaps)';
}
