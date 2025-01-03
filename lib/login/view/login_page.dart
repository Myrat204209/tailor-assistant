import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:dap_foreman_assis/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const LoginPage(),
      settings: const RouteSettings(name: '/login'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        } else {
          await _onWillPop(context);
        }
      },
      child: Scaffold(
        body: BlocProvider(
          create: (context) =>
              LoginBloc(authRepository: context.read<AuthRepository>()),
          child: const LoginView(),
        ),
      ),
    );
  }
}

Future<void> _onWillPop(BuildContext context) async {
  await showDialog<bool>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => const AppDialog(
      buttonText: 'Да',
      title: 'Вы хотите выйти из приложения?',
      onTap: SystemNavigator.pop,
    ),
  );
}
