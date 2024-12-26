// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ui/app_ui.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OperationAppBar(
          docNumber: orderItem.docNumber,
          title: orderItem.itemName,
          onIconClick: () {
            context .read<ReportBoxClient>()
                                        .getNumberOfOperations(sewer);
             context
                .read<ReportsBloc>()
                .add(ReportOrdersRequested(employee: sewer));
            Navigator.pop(context,);
          },
        ),
        const OperationSearchBar(),
        BlocBuilder<ReportsBloc, ReportsState>(
          builder: (context, reportState) {
            return BlocBuilder<EditCubit, EditState>(
              buildWhen: (previous, current) =>
                  previous.operations.length != current.operations.length,
              builder: (context, editState) {
                final cubitOperation = editState.operations;
                if (cubitOperation.isEmpty) {
                  Expanded(child: const Text('Добавьте операцию').centralize());
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: cubitOperation.length,
                    itemBuilder: (context, index) {
                      final operation = cubitOperation[index];
                      final quantity =
                          reportState.getQuantity(operation.workCode);
                      final controller = TextEditingController()
                        ..text = quantity == '0' ? '' : quantity;

                      return AppTextField(
                        colorScheme: colorScheme,
                        titleText: operation.workName,
                        onSubmitted: (quantity) {
                          context.read<ReportsBloc>().add(ReportOperationAdded(
                                employee: sewer,
                                order: orderItem,
                                operation: operation,
                                quantity: int.parse(controller.text),
                              ));
                        },
                        controller: controller,
                        isClose: true,
                        // textFieldKey: Key('operationKey$operation$'),
                        onChanged: (value) {},
                        onRemove: () {
                          context
                            ..read<ReportsBloc>().add(ReportOperationRemoved(
                              employee: sewer,
                              order: orderItem,
                              operation: operation,
                            ))
                            ..read<EditCubit>().removeOperation(operation);
                        },
                        hintText: 'Введите количество',
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
