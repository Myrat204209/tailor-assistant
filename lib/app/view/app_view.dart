import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';

import 'package:dap_foreman_assis/auth/auth.dart';
import 'package:dap_foreman_assis/home/home.dart';
import 'package:dap_foreman_assis/login/view/login_page.dart';
import 'package:dap_foreman_assis/theme_selector/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    Hive.close();
    WidgetsBinding.instance.removeObserver(this);
    // Close Hive boxes if needed
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // App is terminating, close Hive boxes
      Hive.close();
    }
  }

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
  return SafeArea(
    child: LayoutBuilder(
      builder: (context, constraints) {
        return BlocSelector<ThemeModeBloc, ThemeMode, ThemeMode>(
          selector: (state) => state,
          builder: (context, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: _navigatorKey,
              themeMode: themeMode,
              theme: const AppTheme().themeData,
              darkTheme: const AppDarkTheme().themeData,
              home: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state.status == AuthStatus.unauthenticated) {
                    return const LoginPage();
                  } else {
                    return const HomePage();
                  }
                },
              ),
            );
          },
        );
      },
    ),
  );
}


   void _navigateTo(Route<void> route) {
    _navigator.pushAndRemoveUntil<void>(route, (route) => false);
  }
}
