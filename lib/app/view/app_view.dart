import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';

import 'package:dap_foreman_assis/auth/auth.dart';
import 'package:dap_foreman_assis/home/home.dart';
import 'package:dap_foreman_assis/login/login.dart';
import 'package:dap_foreman_assis/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void dispose() {
    // Ensure resources tied to the AuthRepository are cleaned up.
    context.read<AuthRepository>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: _navigatorKey,
            themeMode: ThemeMode.light,
            theme: const AppTheme().themeData,
            darkTheme: const AppDarkTheme().themeData,
            builder: (context, child) {
              return BlocListener<AuthBloc, AuthState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, authState) {
                  if (authState.status == AuthStatus.authenticated) {
                    _navigateTo(HomePage.route());
                  } else if (authState.status ==
                      AuthStatus.unauthenticated) {
                    
                    _navigateTo(LoginPage.route());
                  }
                },
                child: child,
              );
            },
            onGenerateRoute: (_) => SplashPage.route(),
          );
        },
      ),
    );
  }

  void _navigateTo(Route<void> route) {
    _navigator.pushAndRemoveUntil<void>(route, (route) => false);
  }
}
