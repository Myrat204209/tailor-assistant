// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/app/app.dart';
import 'package:dap_foreman_assis/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: AppIconButton(
              foregroundColor: AppColors.secondAccent,
              backgroundColor: AppColors.mainAccent,
              onIconPressed: () => context.read<ThemeCubit>().toggleTheme(),
              icon: Icons.dark_mode_rounded,
            ).paddingOnly(right: 10, top: 30),
          ),
          SizedBox.square(
            dimension: height * 0.44,
            child: Image.asset(
              'assets/auth.png',
              fit: BoxFit.fill,
            ).paddingOnly(right: 45, left: 67),
          ),
          // const Expanded(child: LoginForm()),
          const LoginForm(),
        ],
      ),
    );
  }
}
