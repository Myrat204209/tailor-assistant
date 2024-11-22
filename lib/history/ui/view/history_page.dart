import 'package:dap_foreman_assis/history/history.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const HistoryPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HistoryView(),
    );
  }
}
