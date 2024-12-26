// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class OperationMapAdapter extends TypeAdapter<OperationMap> {
  @override
  final int typeId = 0;

  @override
  OperationMap read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OperationMap(
      key: fields[0] as String,
      value: (fields[1] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, OperationMap obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperationMapAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderMapAdapter extends TypeAdapter<OrderMap> {
  @override
  final int typeId = 1;

  @override
  OrderMap read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderMap(
      key: fields[0] as String,
      operationMaps: (fields[1] as List).cast<OperationMap>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderMap obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.operationMaps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderMapAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
