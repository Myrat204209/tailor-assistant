import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'operation_item.g.dart';

@JsonSerializable()
class OperationItem {
  OperationItem({
    required this.workName,
    required this.workPrice,
    required this.workCode,
  });

  factory OperationItem.fromJson(JsonType json) =>
      _$OperationItemFromJson(json);

  @JsonKey(name: 'work_code')
  final String workCode;

  @JsonKey(name: 'work_name')
  final String workName;

  @JsonKey(name: 'work_price')
  final double workPrice;

  JsonType toJson() => _$OperationItemToJson(this);
}
