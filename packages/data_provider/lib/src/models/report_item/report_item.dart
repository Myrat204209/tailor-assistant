import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_item.g.dart';

@JsonSerializable()
class ReportItem {
  ReportItem({
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
  factory ReportItem.fromJson(JsonType json) => _$ReportItemFromJson(json);

  // Copy constructor
  ReportItem.copy(ReportItem reportItem)
      : employeeCode = reportItem.employeeCode,
        employeeName = reportItem.employeeName,
        itemCode = reportItem.itemCode,
        itemName = reportItem.itemName,
        id = reportItem.id,
        docNumber = reportItem.docNumber,
        workCode = reportItem.workCode,
        workName = reportItem.workName,
        workQuantity = reportItem.workQuantity,
        reportDate = reportItem.reportDate,
        comments = reportItem.comments;

  // Copy with method
  ReportItem copyWith({
    String? employeeCode,
    String? employeeName,
    String? itemCode,
    String? itemName,
    String? docNumber,
    String? workCode,
    String? workName,
    int? workQuantity,
    String? comments,
    int? id,
    String? reportDate,
  }) {
    return ReportItem(
      employeeCode: employeeCode ?? this.employeeCode,
      employeeName: employeeName ?? this.employeeName,
      itemCode: itemCode ?? this.itemCode,
      itemName: itemName ?? this.itemName,
      docNumber: docNumber ?? this.docNumber,
      workCode: workCode ?? this.workCode,
      workName: workName ?? this.workName,
      workQuantity: workQuantity ?? this.workQuantity,
      comments: comments ?? this.comments,
      id: id ?? this.id,
      reportDate: reportDate ?? this.reportDate,
    );
  }

  @JsonKey(name: 'employee_code')
  String? employeeCode;

  @JsonKey(name: 'employee_name')
  String? employeeName;

  @JsonKey(name: 'item_code')
  String? itemCode;

  @JsonKey(name: 'item_name')
  String? itemName;

  @JsonKey(name: 'doc_number')
  String? docNumber;

  @JsonKey(name: 'work_code')
  String? workCode;

  @JsonKey(name: 'work_name')
  String? workName;

  @JsonKey(name: 'work_quantity')
  int? workQuantity;

  String? comments;

  int? id;

  @JsonKey(name: 'report_date')
  String? reportDate;

  // To JSON
  Map<String, dynamic> toJson() => _$ReportItemToJson(this);
}

extension ReportItemValidation on ReportItem {
  bool get isNotEmpty {
    return (employeeCode?.isNotEmpty ?? false) ||
        (employeeName?.isNotEmpty ?? false) ||
        (itemCode?.isNotEmpty ?? false) ||
        (itemName?.isNotEmpty ?? false);
  }
}
