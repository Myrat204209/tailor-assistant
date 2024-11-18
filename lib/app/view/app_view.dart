import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/app/app.dart';
import 'package:dap_foreman_assis/root/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: state,
          theme: const AppTheme().themeData,
          darkTheme: const AppDarkTheme().themeData,
          home: const RootPage(),
          // home: AuthPage(),
        );
      },
    );
  }
}
