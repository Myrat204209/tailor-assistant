// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      itemCode: json['item_code'] as String,
      itemName: json['item_name'] as String,
      attrColor: json['attr_color'] as String,
      attrSize: json['attr_size'] as String,
      attrCollection: json['attr_collection'] as String,
      attrOrder: json['attr_order'] as String,
      attrPrint: json['attr_print'] as String,
      attrVyshyvka: json['attr_vyshyvka'] as String,
      attrTextile: json['attr_textile'] as String,
      attrLekalo: json['attr_lekalo'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      itemMeasure: json['item_measure'] as String,
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'item_code': instance.itemCode,
      'item_name': instance.itemName,
      'attr_color': instance.attrColor,
      'attr_size': instance.attrSize,
      'attr_collection': instance.attrCollection,
      'attr_order': instance.attrOrder,
      'attr_print': instance.attrPrint,
      'attr_vyshyvka': instance.attrVyshyvka,
      'attr_textile': instance.attrTextile,
      'attr_lekalo': instance.attrLekalo,
      'quantity': instance.quantity,
      'item_measure': instance.itemMeasure,
    };
