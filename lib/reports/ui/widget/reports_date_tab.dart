// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dap_foreman_assis/reports/ui/bloc/reports_network_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReportsDateTab extends HookWidget {
  const ReportsDateTab({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDate = useState<int>(0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReportDateArrow(
          quantity: selectedDate.value,
          icon: Icons.arrow_back,
        ),
        Text(
          '${DateTime.now().subtract(Duration(days: selectedDate.value))}',
        ),
        ReportDateArrow(
          quantity: selectedDate.value,
          icon: Icons.arrow_forward,
        ),
      ],
    );
  }
}

class ReportDateArrow extends StatelessWidget {
  const ReportDateArrow({
    required this.quantity,
    required this.icon,
    super.key,
  });

  final int quantity;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () =>
          context.read<ReportsNetworkBloc>().add(ReportsNetworkRequested(
                date: DateTime.now().subtract(
                  Duration(days: quantity),
                ),
              )),
      label: Icon(
        icon,
        color: Colors.blue,
        size: 25,
      ),
    );
  }
}
