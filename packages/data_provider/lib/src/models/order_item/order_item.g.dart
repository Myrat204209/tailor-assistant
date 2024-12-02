// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderItemAdapter extends TypeAdapter<OrderItem> {
  @override
  final int typeId = 2;

  @override
  OrderItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderItem(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String,
      fields[5] as String,
      (fields[6] as List).cast<String>(),
      (fields[7] as List).cast<String>(),
      fields[8] as String,
      (fields[9] as List).cast<String>(),
      (fields[10] as List).cast<String>(),
      (fields[11] as List).cast<String>(),
      (fields[12] as List).cast<String>(),
      (fields[13] as List).cast<String>(),
      (fields[14] as List).cast<String>(),
      fields[15] as double,
      (fields[16] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderItem obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.docNumber)
      ..writeByte(1)
      ..write(obj.dateCreate)
      ..writeByte(2)
      ..write(obj.startOrder)
      ..writeByte(3)
      ..write(obj.finishOrder)
      ..writeByte(4)
      ..write(obj.itemCode)
      ..writeByte(5)
      ..write(obj.itemName)
      ..writeByte(6)
      ..write(obj.attrColor)
      ..writeByte(7)
      ..write(obj.attrSize)
      ..writeByte(8)
      ..write(obj.attrCollection)
      ..writeByte(9)
      ..write(obj.attrOrder)
      ..writeByte(10)
      ..write(obj.attrPrint)
      ..writeByte(11)
      ..write(obj.attrVyshyvka)
      ..writeByte(12)
      ..write(obj.attrTextile)
      ..writeByte(13)
      ..write(obj.attrLekalo)
      ..writeByte(14)
      ..write(obj.attrNombp)
      ..writeByte(15)
      ..write(obj.quantity)
      ..writeByte(16)
      ..write(obj.itemMeasure);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      (json['attr_color'] as List<dynamic>).map((e) => e as String).toList(),
      (json['attr_size'] as List<dynamic>).map((e) => e as String).toList(),
      json['attr_collection'] as String,
      (json['attr_order'] as List<dynamic>).map((e) => e as String).toList(),
      (json['attr_print'] as List<dynamic>).map((e) => e as String).toList(),
      (json['attr_vyshyvka'] as List<dynamic>).map((e) => e as String).toList(),
      (json['attr_textile'] as List<dynamic>).map((e) => e as String).toList(),
      (json['attr_lekalo'] as List<dynamic>).map((e) => e as String).toList(),
      (json['attr_nombp'] as List<dynamic>).map((e) => e as String).toList(),
      (json['quantity'] as num).toDouble(),
      (json['item_measure'] as List<dynamic>).map((e) => e as String).toList(),
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
