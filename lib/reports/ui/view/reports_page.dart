import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<ReportsNetworkBloc>()
        .add(ReportsNetworkRequested(date: DateTime.now()));
    return const Scaffold(
      body: ReportsView(),
    );
  }
}
