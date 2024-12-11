// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/login/login.dart';
import 'package:dap_foreman_assis/theme_selector/bloc/theme_mode_bloc.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final themeMode = context.select((ThemeModeBloc bloc) => bloc.state);
    final controller = TextEditingController();
    return Scaffold(
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onLongPress: () => {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                      content: Text('Вы включили режим разработчика'))),
                const BaseUrlField(),
                // showAdaptiveDialog<String>(
                //   context: context,
                //   builder: (context) => SimpleDialog(
                //     title: const Text('Режим разработчика'),
                //     children: [
                //       AppTextField(
                //         controller: controller,
                //         titleText: 'Изменить IP адрес',
                //         colorScheme: Theme.of(context).colorScheme,
                //         hintText: '192.168.1.1',
                //         onSubmitted: (value) {

                //         },
                //       )
                //     ],
                //   ),
                // )
              },
              child: AppIconButton(
                foregroundColor: AppColors.secondAccent,
                backgroundColor: AppColors.mainAccent,
                onIconPressed: () =>
                    context.read<ThemeModeBloc>().add(const ThemeModeChanged()),
                icon: themeMode == ThemeMode.dark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
              ).paddingOnly(right: 10, top: 30),
            ),
          ),
          SizedBox.square(
            dimension: height * 0.35,
            child: Image.asset(
              'assets/auth.png',
              fit: BoxFit.contain,
            ).paddingOnly(right: 45, left: 67),
          ),
          // const Expanded(child: LoginForm()),
          const LoginForm(),
        ],
      ),
    );
  }
}
