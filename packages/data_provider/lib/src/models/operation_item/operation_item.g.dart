// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationItem _$OperationItemFromJson(Map<String, dynamic> json) =>
    OperationItem(
      workName: json['work_name'] as String,
      workPrice: json['work_price'] as String,
    );

Map<String, dynamic> _$OperationItemToJson(OperationItem instance) =>
    <String, dynamic>{
      'work_name': instance.workName,
      'work_price': instance.workPrice,
    };
