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
    final loginFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final isChecked = useState(false); 


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
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.5,
        child: Column(
          children: [
            UsernameInput(
              controller: loginController,
              focusNode: loginFocusNode,
              nextFocusNode: passwordFocusNode,
            ),
            PasswordInput(
              controller: passwordController,
              focusNode: passwordFocusNode,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox.adaptive(
                  value: isChecked.value,
                  activeColor: AppColors.majorAccent,
                  checkColor: AppColors.majorLightAccent,
                  onChanged: (value) {
                    isChecked.value = value!;
                  },
                ),
                const Text('запомнить меня'),
              ],
            ).paddingOnly(right: 20),

            const Spacer(),
            LoginButton(
              passwordController: passwordController,
              loginController: loginController,
              loginFocusNode: loginFocusNode,
              passwordFocusNode: passwordFocusNode,
            ).paddingOnly(bottom: 24),
          ],
        ),
      ),
    );
  }
}

class UsernameInput extends StatelessWidget {
  const UsernameInput({
    required this.controller,
    required this.focusNode,
    required this.nextFocusNode,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      onSubmitted: (p0) {
        log('OnSubmitted $p0');
        FocusScope.of(context).requestFocus(nextFocusNode);
      },
      onChanged: (value) {
        log('OnChanged $value');
      },
      isNext: true,
      colorScheme: Theme.of(context).colorScheme,
      hintText: 'Введите ваш логин',
      titleText: 'Логин',
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
    
      hintText: 'Введите ваш пароль',
      titleText: 'Пароль',
      onSubmitted: (p0) {
        log('OnSubmitted $p0');
        focusNode.unfocus();
      },
      onChanged: (value) {
        log('OnChanged $value');
      },
      controller: controller,
      focusNode: focusNode,
      colorScheme: Theme.of(context).colorScheme,
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    required this.passwordController,
    required this.loginController,
    required this.loginFocusNode,
    required this.passwordFocusNode,
    super.key,
  });

  final TextEditingController passwordController;
  final TextEditingController loginController;
  final FocusNode loginFocusNode;
  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        key: const Key('loginForm_continue_raisedButton'),
        onPressed: () {
          // Unfocus all focus nodes
          loginFocusNode.unfocus();
          passwordFocusNode.unfocus();

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
    ).paddingSymmetric(horizontal: 30);
  }
}
