import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Color(0xFFE2EAFF),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: const AppTheme().themeData,
      // darkTheme: const AppDarkTheme().themeData,
      home: const LoginPage(),
      // home: AuthPage(),
    );
  }
}
