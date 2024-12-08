import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:dap_foreman_assis/reports/ui/bloc/reports_network_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ReportsAppBar(),
        const ReportsDateTab(),
        BlocBuilder<ReportsNetworkBloc, ReportsNetworkState>(
          builder: (context, state) {
            final reportsList = state.reports;
            return Expanded(
              child: reportsList.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      itemCount: reportsList.length,
                      itemBuilder: (context, index) {
                        return ReportTile(
                          name: 'Report$index',
                          onTap: () {},
                        ).paddingSymmetric(horizontal: 20, vertical: 7);
                      },
                    ),
            );
          },
        ),
      ],
    );
  }
}
