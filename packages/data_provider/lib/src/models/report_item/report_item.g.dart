// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportItem _$ReportItemFromJson(Map<String, dynamic> json) => ReportItem(
      employeeCode: json['employee_code'] as String?,
      employeeName: json['employee_name'] as String?,
      itemCode: json['item_code'] as String?,
      itemName: json['item_name'] as String?,
      docNumber: json['doc_number'] as String?,
      workCode: json['work_code'] as String?,
      workName: json['work_name'] as String?,
      workQuantity: (json['work_quantity'] as num?)?.toInt(),
      comments: json['comments'] as String?,
      id: (json['id'] as num?)?.toInt(),
      reportDate: json['report_date'] as String?,
    );

Map<String, dynamic> _$ReportItemToJson(ReportItem instance) =>
    <String, dynamic>{
      'employee_code': instance.employeeCode,
      'employee_name': instance.employeeName,
      'item_code': instance.itemCode,
      'item_name': instance.itemName,
      'doc_number': instance.docNumber,
      'work_code': instance.workCode,
      'work_name': instance.workName,
      'work_quantity': instance.workQuantity,
      'comments': instance.comments,
      'id': instance.id,
      'report_date': instance.reportDate,
    };
