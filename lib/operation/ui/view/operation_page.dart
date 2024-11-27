// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperationPage extends StatelessWidget {
  const OperationPage({
    required this.order,
    required this.sewer,
    super.key,
  });
  static Route<void> route({
    required OrderItem order,
    required EmployeesItem sewer,
  }) {
    return MaterialPageRoute<void>(
      builder: (context) => OperationPage(
        sewer: sewer,
        order: order,
      ),
    );
  }

  final OrderItem order;
  final EmployeesItem sewer;
  @override
  Widget build(BuildContext context) {
    final operationsList = context
        .select((OperationBloc bloc) => bloc.state.operations)
        .map(
          (e) => e.workName,
        )
        .toList();
    context.read<EditCubit>().setOperations(operationsList); 
    // ..clearOperations();
    return Scaffold(
      body: OperationView(
        name: order,
        sewer: sewer,
      ),
    );
  }
}
