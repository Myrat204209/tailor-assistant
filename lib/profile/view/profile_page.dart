// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:dap_foreman_assis/profile/cubit/profile_cubit.dart';
import 'package:dap_foreman_assis/profile/profile.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'profile_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    required this.profileName,
    super.key,
  });
  final EmployeesItem profileName;
  static Route<void> route(EmployeesItem name) {
    return MaterialPageRoute<void>(
      builder: (_) => ProfilePage(
        profileName: name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ordersList =
        context.select((OrdersBloc bloc) => bloc.state.orders).toList();
    context.read<ProfileCubit>()
      ..setProducts(ordersList)
      ..clearProduct();

    return Scaffold(
      body: ProfileView(name: profileName),
    );
  }
}
