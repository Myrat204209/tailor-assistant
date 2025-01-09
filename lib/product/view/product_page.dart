// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:dap_foreman_assis/product/product.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'product_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    required this.profileName,
    super.key,
    this.reportRoot = false,
  });
  final bool reportRoot;
  final EmployeesItem profileName;
  static Route<void> route(EmployeesItem name, {bool reportRoot = false}) {
    return MaterialPageRoute<void>(
      builder: (_) => ProfilePage(profileName: name, reportRoot: reportRoot),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ordersList =
        context.select((OrdersBloc bloc) => bloc.state.orders).toList();
    if (!reportRoot) {
      context
        ..read<ReportsBloc>().add(ReportOrdersRequested(employee: profileName))
        ..read<ProductCubit>().setProducts(ordersList);
    } else {}

    return Scaffold(
      body: ProfileView(employee: profileName),
    );
  }
}
