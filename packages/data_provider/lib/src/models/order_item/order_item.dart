import 'package:data_provider/data_provider.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 2)
class OrderItem {

  factory OrderItem.fromJson(JsonType json) => _$OrderItemFromJson(json);
  const OrderItem(
    this.docNumber,
    this.dateCreate,
    this.startOrder,
    this.finishOrder,
    this.itemCode,
    this.itemName,
    this.attrColor,
    this.attrSize,
    this.attrCollection,
    this.attrOrder,
    this.attrPrint,
    this.attrVyshyvka,
    this.attrTextile,
    this.attrLekalo,
    this.attrNombp,
    this.quantity,
    this.itemMeasure,
  );

  @HiveField(0)
  @JsonKey(name: 'doc_number')
  final String? docNumber;

  @HiveField(1)
  @JsonKey(name: 'date_create_date')
  final String? dateCreate;

  @HiveField(2)
  @JsonKey(name: 'start_order')
  final String? startOrder;

  @HiveField(3)
  @JsonKey(name: 'finish_order')
  final String? finishOrder;

  @HiveField(4)
  @JsonKey(name: 'item_code')
  final String itemCode;

  @HiveField(5)
  @JsonKey(name: 'item_name')
  final String itemName;

  @HiveField(6)
  @JsonKey(name: 'attr_color')
  final List<String> attrColor;

  @HiveField(7)
  @JsonKey(name: 'attr_size')
  final List<String> attrSize;

  @HiveField(8)
  @JsonKey(name: 'attr_collection')
  final String attrCollection;

  @HiveField(9)
  @JsonKey(name: 'attr_order')
  final List<String> attrOrder;

  @HiveField(10)
  @JsonKey(name: 'attr_print')
  final List<String> attrPrint;

  @HiveField(11)
  @JsonKey(name: 'attr_vyshyvka')
  final List<String> attrVyshyvka;

  @HiveField(12)
  @JsonKey(name: 'attr_textile')
  final List<String> attrTextile;

  @HiveField(13)
  @JsonKey(name: 'attr_lekalo')
  final List<String> attrLekalo;

  @HiveField(14)
  @JsonKey(name: 'attr_nombp')
  final List<String> attrNombp;

  @HiveField(15)
  @JsonKey(name: 'quantity')
  final double quantity;

  @HiveField(16)
  @JsonKey(name: 'item_measure')
  final List<String> itemMeasure;
  JsonType toJson() => _$OrderItemToJson(this);
}
