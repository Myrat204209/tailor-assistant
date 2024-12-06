import 'package:data_provider/data_provider.dart';

import 'package:json_annotation/json_annotation.dart';

part 'employees_item.g.dart'; 

@JsonSerializable()
class EmployeesItem {
  const EmployeesItem({
    required this.employeeCode,
    required this.employeeName,
  });

  factory EmployeesItem.fromJson(JsonType json) =>
      _$EmployeesItemFromJson(json);

  @JsonKey(name: 'employee_code')
  final String employeeCode;

  @JsonKey(name: 'employee_name')
  final String employeeName;

  JsonType toJson() => _$EmployeesItemToJson(this);
}
