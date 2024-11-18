// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      json['docNumber'] as String,
      json['dateCreate'] as String,
      json['startOrder'] as String,
      json['finishOrder'] as String,
      (json['items'] as List<dynamic>?)
          ?.map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'docNumber': instance.docNumber,
      'dateCreate': instance.dateCreate,
      'startOrder': instance.startOrder,
      'finishOrder': instance.finishOrder,
      'items': instance.items?.map((e) => e.toJson()).toList(),
    };
