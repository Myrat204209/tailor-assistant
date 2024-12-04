import 'package:data_provider/data_provider.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'operation_item.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class OperationItem {
  OperationItem({
    required this.workName,
    required this.workPrice,
    required this.workCode,
  });

  factory OperationItem.fromJson(JsonType json) =>
      _$OperationItemFromJson(json);

  @HiveField(0)
  @JsonKey(name: 'work_code')
  final String workCode;

  @HiveField(1)
  @JsonKey(name: 'work_name')
  final String workName;

  @HiveField(2)
  @JsonKey(name: 'work_price')
  final double workPrice;

  JsonType toJson() => _$OperationItemToJson(this);
}
