import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:dap_foreman_assis/auth/auth.dart';
import 'package:dap_foreman_assis/home/home.dart';
import 'package:dap_foreman_assis/login/login.dart';
import 'package:dap_foreman_assis/splash/splash.dart';
import 'package:dap_foreman_assis/theme_selector/theme_selector.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  @override
  void initState() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapters();
    }

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return BlocSelector<ThemeModeBloc, ThemeMode, ThemeMode>(
            selector: (state) => state,
            builder: (context, themeMode) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: themeMode,
                theme: const AppTheme().themeData,
                darkTheme: const AppDarkTheme().themeData,
                home: authState.status == AuthStatus.unknown
                    ? const SplashPage()
                    : authState.status == AuthStatus.authenticated
                        ? const HomePage()
                        : const LoginPage(),
              );
            },
          );
        },
      ),
    );
  }
}
