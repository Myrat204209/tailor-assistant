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
      (json['items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ProductItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'doc_number': instance.docNumber,
      'date_create_date': instance.dateCreate,
      'start_order': instance.startOrder,
      'finish_order': instance.finishOrder,
      'items': instance.items?.map((e) => e?.toJson()).toList(),
    };
