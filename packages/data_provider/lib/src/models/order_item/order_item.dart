// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderItem {
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
  @JsonKey(name: 'doc_number')
  final String? docNumber;
  @JsonKey(name: 'date_create_date')
  final String? dateCreate;
  @JsonKey(name: 'start_order')
  final String? startOrder;
  @JsonKey(name: 'finish_order')
  final String? finishOrder;
  @JsonKey(name: 'item_code')
  final String itemCode;
  @JsonKey(name: 'item_name')
  final String itemName;

  @JsonKey(name: 'attr_color')
  final List<String> attrColor;

  @JsonKey(name: 'attr_size')
  final List<String> attrSize;

  //TODO:Change to List<String>
  @JsonKey(name: 'attr_collection')
  final String attrCollection;

  @JsonKey(name: 'attr_order')
  final List<String> attrOrder;

  @JsonKey(name: 'attr_print')
  final List<String> attrPrint;

  @JsonKey(name: 'attr_vyshyvka')
  final List<String> attrVyshyvka;

  @JsonKey(name: 'attr_textile')
  final List<String> attrTextile;

  @JsonKey(name: 'attr_lekalo')
  final List<String> attrLekalo;
  @JsonKey(name: 'attr_nombp')
  final List<String> attrNombp;
  @JsonKey(name: 'quantity')
  final double quantity;

  @JsonKey(name: 'item_measure')
  final List<String> itemMeasure;

  factory OrderItem.fromJson(JsonType json) => _$OrderItemFromJson(json);
  JsonType toJson() => _$OrderItemToJson(this);
}
