// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      json['doc_number'] as String?,
      json['date_create_date'] as String?,
      json['start_order'] as String?,
      json['finish_order'] as String?,
      json['item_code'] as String,
      json['item_name'] as String,
      (json['attr_color'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['attr_size'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['attr_collection'] as String?,
      (json['attr_order'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['attr_print'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['attr_vyshyvka'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (json['attr_textile'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (json['attr_lekalo'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['attr_nombp'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['quantity'] as num).toDouble(),
      (json['item_measure'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'doc_number': instance.docNumber,
      'date_create_date': instance.dateCreate,
      'start_order': instance.startOrder,
      'finish_order': instance.finishOrder,
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
      'attr_nombp': instance.attrNombp,
      'quantity': instance.quantity,
      'item_measure': instance.itemMeasure,
    };
