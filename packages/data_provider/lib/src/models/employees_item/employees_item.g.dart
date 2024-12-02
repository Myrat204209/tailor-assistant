// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeesItemAdapter extends TypeAdapter<EmployeesItem> {
  @override
  final int typeId = 0;

  @override
  EmployeesItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeesItem(
      employeeCode: fields[0] as String,
      employeeName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeesItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.employeeCode)
      ..writeByte(1)
      ..write(obj.employeeName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeesItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeesItem _$EmployeesItemFromJson(Map<String, dynamic> json) =>
    EmployeesItem(
      employeeCode: json['employee_code'] as String,
      employeeName: json['employee_name'] as String,
    );

Map<String, dynamic> _$EmployeesItemToJson(EmployeesItem instance) =>
    <String, dynamic>{
      'employee_code': instance.employeeCode,
      'employee_name': instance.employeeName,
    };
