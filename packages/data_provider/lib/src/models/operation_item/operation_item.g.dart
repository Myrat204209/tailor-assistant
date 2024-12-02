// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperationItemAdapter extends TypeAdapter<OperationItem> {
  @override
  final int typeId = 1;

  @override
  OperationItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OperationItem(
      workName: fields[1] as String,
      workPrice: fields[2] as double,
      workCode: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OperationItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.workCode)
      ..writeByte(1)
      ..write(obj.workName)
      ..writeByte(2)
      ..write(obj.workPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperationItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationItem _$OperationItemFromJson(Map<String, dynamic> json) =>
    OperationItem(
      workName: json['work_name'] as String,
      workPrice: (json['work_price'] as num).toDouble(),
      workCode: json['work_code'] as String,
    );

Map<String, dynamic> _$OperationItemToJson(OperationItem instance) =>
    <String, dynamic>{
      'work_code': instance.workCode,
      'work_name': instance.workName,
      'work_price': instance.workPrice,
    };
