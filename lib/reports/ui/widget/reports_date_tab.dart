// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class ReportsDateTab extends HookWidget {
  const ReportsDateTab({super.key});

  @override
  Widget build(BuildContext context) {
    final startingDate = DateTime.now().subtract(const Duration(days: 1));
    final selectedDate = useState<int>(0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReportDateArrow(
          quantity: selectedDate.value - 1,
          icon: Icons.arrow_back_ios_rounded,
          onPressed: () {
            selectedDate.value = selectedDate.value - 1;
          },
        ),
        Text(
          DateFormat('dd.MM.yyyy').format(
            startingDate.add(Duration(days: selectedDate.value)),
          ),
          style: const AppTextStyle.text()
              .pageTitle()
              .withColor(AppColors.textLightTitle),
        ),
        ReportDateArrow(
          quantity: selectedDate.value + 1,
          icon: Icons.arrow_forward_ios_rounded,
          onPressed: () {
            selectedDate.value = selectedDate.value + 1;
          },
        ),
      ],
    ).paddingSymmetric(vertical: 24, horizontal: 20);
  }
}

class ReportDateArrow extends StatelessWidget {
  const ReportDateArrow({
    required this.quantity,
    required this.onPressed,
    required this.icon,
    super.key,
  });

  final int quantity;
  final VoidCallback onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        shape: const CircleBorder(),
        iconColor: colorScheme.primary,
        padding: const EdgeInsets.all(12),
        // disabledBackgroundColor: colorScheme.primaryContainer,
        // disabledIconColor: colorScheme.shadow,
        backgroundColor: colorScheme.onPrimary,
      ),
      onPressed: quantity < 2 && quantity > -2
          ? () {
              onPressed.call();
              context.read<ReportsNetworkBloc>().add(
                    ReportsNetworkRequested(
                      date: DateTime.now().add(Duration(days: quantity - 1)),
                    ),
                  );
            }
          : null,
      label: Icon(
        icon,
        size: 30,
      ),
    );
  }
}
