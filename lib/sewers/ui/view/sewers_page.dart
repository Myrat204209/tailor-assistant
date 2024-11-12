import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/profile/profile.dart';
import 'package:flutter/material.dart';

part 'sewers_view.dart';

class SewersPage extends StatelessWidget {
  const SewersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SewersView(),
    );
  }
}
