import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Column(
        children: [
          _UsernameInput(),
          _PasswordInput(),
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
          _LoginButton(),
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.username.displayError,
    );
    return AppTextField(
      colorScheme: Theme.of(context).colorScheme,
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (username) =>
          context.read<LoginBloc>().add(LoginUsernameChanged(username)),
      hintText: 'Login',
      titleText: 'Логин',
      errorText: displayError != null ? 'invalid username' : null,
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.password.displayError,
    );

    return AppTextField(
      key: const Key('loginForm_passwordInput_textField'),
      hintText: 'pass123',
      titleText: 'Пароль',
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password));
      },
      errorText: displayError != null ? 'invalid password' : null,
      colorScheme: Theme.of(context).colorScheme,
      // isClose: true,
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (LoginBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return SizedBox(
      width: double.infinity,
      height: 60,
      child: FilledButton(
        key: const Key('loginForm_continue_raisedButton'),
        onPressed: isValid
            ? () => context.read<LoginBloc>().add(const LoginSubmitted())
            : null,
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
