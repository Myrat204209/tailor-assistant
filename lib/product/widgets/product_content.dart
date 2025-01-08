// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/product/product.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductContent extends StatelessWidget {
  const ProductContent({
    required this.allOrders,
    required this.employee,
    super.key,
  });
  final List<OrderItem> allOrders;
  final EmployeesItem employee;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<ReportsBloc, ReportsState>(
      buildWhen: (previous, current) =>
          previous.orders?.length != current.orders?.length,
      builder: (context, state) {
        final orders = state.orders?.reversed.toList();
        if (orders?.isEmpty ?? true) {
          const Text('Добавьте изделия').centralize();
        }
        return ListView.builder(
          itemCount: orders?.length ?? 0,
          itemBuilder: (context, index) {
            final productName = orders![index];
            final product = allOrders.firstWhere(
              (product) => product.docNumber == productName.key,
            );
            return ProductTile(
              title: product.itemName,
              docNumber: product.docNumber,
              onDeleteTap: () {
                context
                    .read<ReportsBloc>()
                    .add(ReportOrderRemoved(employee, product));
              },
              colorScheme: colorScheme,
              onEditTap: () {
                context.read<ReportsBloc>().add(ReportOperationsRequested(
                      employee: employee,
                      order: product,
                    ));
                Navigator.of(context).push(
                  OperationPage.route(
                    order: product,
                    sewer: employee,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
