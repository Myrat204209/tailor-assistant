import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_item.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductItem {
  ProductItem({
    required this.itemCode,
    required this.itemName,
    required this.attrColor,
    required this.attrSize,
    required this.attrCollection,
    required this.attrOrder,
    required this.attrPrint,
    required this.attrVyshyvka,
    required this.attrTextile,
    required this.attrLekalo,
    required this.quantity,
    required this.itemMeasure,
  });
  factory ProductItem.fromJson(JsonType json) => _$ProductItemFromJson(json);

  @JsonKey(name: 'item_code')
  final String itemCode;

  @JsonKey(name: 'item_name')
  final String itemName;

  @JsonKey(name: 'attr_color')
  final String attrColor;

  @JsonKey(name: 'attr_size')
  final String attrSize;

  @JsonKey(name: 'attr_collection')
  final String attrCollection;

  @JsonKey(name: 'attr_order')
  final String attrOrder;

  @JsonKey(name: 'attr_print')
  final String attrPrint;

  @JsonKey(name: 'attr_vyshyvka')
  final String attrVyshyvka;

  @JsonKey(name: 'attr_textile')
  final String attrTextile;

  @JsonKey(name: 'attr_lekalo')
  final String attrLekalo;

  @JsonKey(name: 'quantity')
  final double quantity;

  @JsonKey(name: 'item_measure')
  final String itemMeasure;
  JsonType toJson() => _$ProductItemToJson(this);
}
