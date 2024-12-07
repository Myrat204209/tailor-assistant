import 'package:hive/hive.dart';

part 'hive_box_adapters.g.dart';

// @HiveType(typeId: 0)
// class OperationMap {
//   OperationMap({required this.key, required this.value});
//   @HiveField(0)
//   final String key;
//   @HiveField(1)
//   final int value;
// }

// @HiveType(typeId: 1)
// class OrderMap {
//   OrderMap({required this.key, required this.operationMaps});
//   @HiveField(0)
//   final String key;
//   @HiveField(1)
//   final List<OperationMap> operationMaps;
// }

@HiveType(typeId: 0)
class OperationMap extends HiveObject {
  OperationMap({required this.key, required this.value});

  @override
  @HiveField(0)
  final String key; // Corresponds to workCode

  @HiveField(1)
  int value; // Quantity, mutable to allow updates

  @override
  String toString() => 'OperationMap(key: $key, value: $value)';
}

// OrderMap.dart
@HiveType(typeId: 1)
class OrderMap extends HiveObject {
  OrderMap({required this.key, required this.operationMaps});

  @override
  @HiveField(0)
  final String key; // Corresponds to itemCode

  @HiveField(1)
  List<OperationMap> operationMaps;

  @override
  String toString() => 'OrderMap(key: $key, operations: $operationMaps)';
}
