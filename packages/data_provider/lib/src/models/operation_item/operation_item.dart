import 'package:data_provider/data_provider.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'operation_item.g.dart'; // This is necessary for generating both Hive adapter and JSON serialization

@JsonSerializable()
@HiveType(
    typeId:
        1,) // Define a unique typeId for this class (start from 1 or another number)
class OperationItem {
  OperationItem({
    required this.workName,
    required this.workPrice,
    required this.workCode,
  });

  // Factory method for JSON serialization
  factory OperationItem.fromJson(JsonType json) =>
      _$OperationItemFromJson(json);

  @HiveField(0) // Unique field id for Hive
  @JsonKey(name: 'work_code')
  final String workCode;

  @HiveField(1) // Unique field id for Hive
  @JsonKey(name: 'work_name')
  final String workName;

  @HiveField(2) // Unique field id for Hive
  @JsonKey(name: 'work_price')
  final double workPrice;

  JsonType toJson() => _$OperationItemToJson(this);
}
