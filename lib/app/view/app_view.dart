import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:dap_foreman_assis/app/app.dart';
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
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  void dispose() {
    context.read<AuthRepository>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: _navigatorKey,
                themeMode: state,
                theme: const AppTheme().themeData,
                darkTheme: const AppDarkTheme().themeData,
                builder: (context, child) {
                  return BlocListener<AuthBloc, AuthState>(
                    listenWhen: (previous, current) =>
                        previous.status != current.status,
                    listener: (context, state) {
                      if (state.status == AuthStatus.authenticated) {
                        _navigator.pushAndRemoveUntil<void>(
                          HomePage.route(),
                          (route) => false,
                        );
                      }
                      if (state.status == AuthStatus.unauthenticated) {
                        _navigator.pushAndRemoveUntil<void>(
                          LoginPage.route(),
                          (route) => false,
                        );
                      }
                    },
                    child: child,
                  );
                },
                onGenerateRoute: (_) => SplashPage.route(),
              );
            },
          );
        },
      ),
    );
  }
}
