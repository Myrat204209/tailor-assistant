// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperationPage extends StatelessWidget {
  const OperationPage({
    required this.productName,
    super.key,
  });
  static Route<void> route({required String product}) {
    return MaterialPageRoute<void>(
      builder: (context) => OperationPage(
        productName: product,
      ),
    );
  }

  final String productName;
  @override
  Widget build(BuildContext context) {
    final operationsList = context
        .select((OperationBloc bloc) => bloc.state.operations)
        .map(
          (e) => e.workName,
        )
        .toList();
    context.read<EditCubit>()
      ..setOperations(operationsList)
      ..clearOperations();
    return Scaffold(
      body: OperationView(
        name: productName,
      ),
    );
  }
}
