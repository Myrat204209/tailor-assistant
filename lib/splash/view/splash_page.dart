import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthSubscriptionRequested());
    return Scaffold(
      body: const CircularProgressIndicator.adaptive().centralize(),
    );
  }
}
