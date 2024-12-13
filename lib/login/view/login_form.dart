// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';

class LoginForm extends HookWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = useTextEditingController();
    final loginController = useTextEditingController();
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(
                'Неверный логин или пароль',
                style: const AppTextStyle.text().description(),
              )),
            );
        }
      },
      child: Column(
        children: [
          UsernameInput(
            controller: loginController,
          ),
          PasswordInput(
            controller: passwordController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Checkbox.adaptive(
                value: true,
                activeColor: AppColors.majorAccent,
                checkColor: AppColors.majorLightAccent,
                onChanged: (value) {},
              ),
              const Text('запомнить меня'),
            ],
          ).paddingOnly(right: 20),
          // const Expanded(child: SizedBox.shrink()),
          LoginButton(
            passwordController: passwordController,
            loginController: loginController,
          ),
        ],
      ),
    );
  }
}

class UsernameInput extends StatelessWidget {
  const UsernameInput({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    // final displayError = context.select(
    //   (LoginBloc bloc) => bloc.state.username.displayError,
    // );
    return AppTextField(
      controller: controller,
      onSubmitted: (p0) {
        log('OnSubmitted $p0');
      },
      onChanged: (value){
        log('OnChanged $value');
      },
      isNext: true,
      colorScheme: Theme.of(context).colorScheme,
      // key: const Key('loginForm_usernameInput_textField'),
      // onSubmitted: (username) =>
      //     context.read<LoginBloc>().add(LoginUsernameChanged(username)),
      // onChanged: (username) =>
      //     context.read<LoginBloc>().add(LoginUsernameChanged(username)),
      hintText: 'Введите ваш логин',
      titleText: 'Логин',
      // errorText: displayError != null ? 'Неверный логин' : null,
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({required this.controller, super.key});

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    // final displayError = context.select(
    //   (LoginBloc bloc) => bloc.state.password.displayError,
    // );

    return AppTextField(
      // key: const Key('loginForm_passwordInput_textField'),
      hintText: 'Введите ваш пароль',
      titleText: 'Пароль',
      onSubmitted: (p0) {
        log('OnSubmitted $p0');
      },
      onChanged: (value){
        log('OnChanged $value');
      },
      controller: controller,
      // onSubmitted: (password) {
      //   context.read<LoginBloc>().add(LoginPasswordChanged(password));
      // },
      // errorText: displayError != null ? 'Некорректный пароль' : null,
      colorScheme: Theme.of(context).colorScheme,
      // isClose: true,
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    required this.passwordController,
    required this.loginController,
    super.key,
  });

  final TextEditingController passwordController;
  final TextEditingController loginController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: FilledButton(
        key: const Key('loginForm_continue_raisedButton'),
        onPressed: () {
          // Access the text from the controllers
          final login = loginController.text.trim();
          final password = passwordController.text.trim();

          // Dispatch the LoginSubmitted event with the retrieved text
          context
              .read<LoginBloc>()
              .add(LoginSubmitted(login: login, password: password));
        },
        style: FilledButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          'Авторизоваться',
          style: const AppTextStyle.text().pageTitle(),
        ),
      ),
    ).paddingSymmetric(horizontal: 20, vertical: 24);
  }
}
