// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OperationView extends HookWidget {
  const OperationView({
    required this.orderItem,
    required this.operationList,
    required this.sewer,
    super.key,
  });
  final OrderItem orderItem;
  final List<OperationItem> operationList;
  final EmployeesItem sewer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OperationAppBar(
          docNumber: orderItem.docNumber,
          title: orderItem.itemName,
          onIconClick: () {
            context
                .read<ReportsBloc>()
                .add(ReportOrdersRequested(employee: sewer));
            Navigator.pop(context);
          },
        ),
        const OperationSearchBar(),
        Expanded(
            child: OperationContent(
          sewer: sewer,
          orderItem: orderItem,
        )),
      ],
    );
  }
}
