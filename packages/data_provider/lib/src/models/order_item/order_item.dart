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
  @JsonKey(name: 'doc_number')
  final String? docNumber;
  @JsonKey(name: 'date_create_date')
  final String? dateCreate;
  @JsonKey(name: 'start_order')
  final String? startOrder;
  @JsonKey(name: 'finish_order')
  final String? finishOrder;
  final List<ProductItem?>? items;

  factory OrderItem.fromJson(JsonType json) => _$OrderItemFromJson(json);
  JsonType toJson() => _$OrderItemToJson(this);
}
