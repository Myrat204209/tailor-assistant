// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees_item.dart';

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
