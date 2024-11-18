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
    this.items,
  );
  final String docNumber;
  final String dateCreate;
  final String startOrder;
  final String finishOrder;
  final List<ProductItem>? items;

  factory OrderItem.fromJson(JsonType json) => _$OrderItemFromJson(json);
  JsonType toJson() => _$OrderItemToJson(this);
}
