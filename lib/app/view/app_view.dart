import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/app/app.dart';
import 'package:dap_foreman_assis/auth/auth.dart';
import 'package:dap_foreman_assis/home/home.dart';
import 'package:dap_foreman_assis/login/login.dart';

import 'package:dap_foreman_assis/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ScreenUtilInit(
            designSize: Size(constraints.maxWidth, constraints.maxHeight),
            builder: (context, child) {
              return BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, state) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    navigatorKey: _navigatorKey,
                    theme: const AppTheme().themeData,
                    themeMode: state,
                    darkTheme: const AppDarkTheme().themeData,
                    builder: (context, child) {
                      return BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          switch (state) {
                            case AuthState.authenticated:
                              _navigator.pushAndRemoveUntil<void>(
                                HomePage.route(),
                                (route) => false,
                              );
                            case AuthState.unauthenticated:
                              _navigator.pushAndRemoveUntil<void>(
                                LoginPage.route(),
                                (route) => false,
                              );
                            case AuthState.unknown:
                              break;
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
          );
        },
      ),
    );
  }
}
