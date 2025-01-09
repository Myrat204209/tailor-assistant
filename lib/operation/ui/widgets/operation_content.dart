// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperationContent extends StatelessWidget {
  final EmployeesItem sewer;
  final OrderItem orderItem;

  const OperationContent({
    required this.sewer,
    required this.orderItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final reportState = context.select((ReportsBloc bloc) => bloc.state);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<EditCubit, EditState>(
      buildWhen: (previous, current) =>
          previous.operations.length != current.operations.length,
      builder: (context, editState) {
        final cubitOperation = editState.operations;
        if (cubitOperation.isEmpty) {
          const Text('Добавьте операцию').centralize();
        }

        return ListView.builder(
            itemCount: cubitOperation.length,
            itemBuilder: (context, index) {
              final operation = cubitOperation[index];
              final quantity = reportState.getQuantity(operation.workCode);
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
                onChanged: (value) {},
                onRemove: () {
                  context
                    ..read<ReportsBloc>().add(ReportOperationRemoved(
                      employee: sewer,
                      order: orderItem,
                      operation: operation,
                    ))
                    ..read<EditCubit>().removeOperation(operation);
                  controller.dispose();
                },
                hintText: 'Введите количество',
              );
            });
      },
    );
  }
}
