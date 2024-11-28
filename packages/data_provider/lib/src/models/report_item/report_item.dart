import 'package:json_annotation/json_annotation.dart';

part 'report_item.g.dart';

@JsonSerializable()
class ReportItem {
 const ReportItem({
    this.employeeCode,
    this.employeeName,
    this.itemCode,
    this.itemName,
    this.docNumber,
    this.workCode,
    this.workName,
    this.workQuantity,
    this.comments,
    this.id,
    this.reportDate,
  });

  // From JSON
  factory ReportItem.fromJson(Map<String, dynamic> json) =>
      _$ReportItemFromJson(json);
  @JsonKey(name: 'employee_code')
  final String? employeeCode;

  @JsonKey(name: 'employee_name')
  final String? employeeName;

  @JsonKey(name: 'item_code')
  final String? itemCode;

  @JsonKey(name: 'item_name')
  final String? itemName;

  @JsonKey(name: 'doc_number')
  final String? docNumber;

  @JsonKey(name: 'work_code')
  final String? workCode;

  @JsonKey(name: 'work_name')
  final String? workName;

  @JsonKey(name: 'work_quantity')
  final int? workQuantity;

  final String? comments;

  final int? id;

  @JsonKey(name: 'report_date')
  final String? reportDate;

  // To JSON
  Map<String, dynamic> toJson() => _$ReportItemToJson(this);
}
