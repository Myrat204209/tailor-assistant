// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_provider/data_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employees_item.g.dart';

@JsonSerializable()
class EmployeesItem {
  const EmployeesItem({
    required this.employeeCode,
    required this.employeeName,
    required this.id,
  });
  @JsonKey(name: 'employee_code')
  final String employeeCode;
  @JsonKey(name: 'employee_name')
  final String employeeName;
  @JsonKey(name: '_fld23708')
  final String id;

  factory EmployeesItem.fromJson(JsonType json) =>
      _$EmployeesItemFromJson(json);
  JsonType toJson() => _$EmployeesItemToJson(this);
}
