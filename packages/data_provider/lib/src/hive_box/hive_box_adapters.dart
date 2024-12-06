import 'package:hive/hive.dart';

part 'hive_box_adapters.g.dart';

@HiveType(typeId: 0)
class OperationMap {
  const OperationMap({required this.key, required this.value});
  @HiveField(0)
  final String key;
  @HiveField(1)
  final int value;
}

@HiveType(typeId: 1)
class OrderMap {
  const OrderMap({required this.key, required this.operationMaps});
  @HiveField(0)
  final String key;
  @HiveField(1)
  final List<OperationMap> operationMaps;
}
