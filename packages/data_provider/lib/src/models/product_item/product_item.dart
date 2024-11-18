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
  String itemCode;

  @JsonKey(name: 'item_name')
  String itemName;

  @JsonKey(name: 'attr_color')
  String attrColor;

  @JsonKey(name: 'attr_size')
  String attrSize;

  @JsonKey(name: 'attr_collection')
  String attrCollection;

  @JsonKey(name: 'attr_order')
  String attrOrder;

  @JsonKey(name: 'attr_print')
  String attrPrint;

  @JsonKey(name: 'attr_vyshyvka')
  String attrVyshyvka;

  @JsonKey(name: 'attr_textile')
  String attrTextile;

  @JsonKey(name: 'attr_lekalo')
  String attrLekalo;

  @JsonKey(name: 'quantity')
  double quantity;

  @JsonKey(name: 'item_measure')
  String itemMeasure;
  JsonType toJson() => _$ProductItemToJson(this);
}
