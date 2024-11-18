// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auth_repository/auth_repository.dart';
import 'package:dap_foreman_assis/app/app.dart';
import 'package:dap_foreman_assis/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  const App({
    required UserRepository userRepository,
    required AuthRepository authRepository,
    super.key,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ScreenUtilInit(
            designSize: Size(constraints.maxWidth, constraints.maxHeight),
            builder: (context, child) => const AppView(),
          );
        },
      ),
    );
  }
}
