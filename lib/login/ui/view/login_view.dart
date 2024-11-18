// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: AppIconButton(
              foregroundColor: AppColors.secondAccent,
              backgroundColor: AppColors.mainAccent,
              onIconPressed: () {},
              icon: Icons.dark_mode_rounded,
            ).paddingOnly(right: 10, top: 30),
          ),
          Image.asset(
            'assets/auth.png',
            fit: BoxFit.fill,
          ).paddingOnly(top: 30, right: 45, left: 67),
          AppTextField(
            controller: nameController,
            hintText: '1234',
            titleText: 'Login',
            // isClose: true,
          ),
          AppTextField(
            controller: passwordController,
            hintText: '12345',
            titleText: 'Password',
            // isClose: true,
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
          const Expanded(child: SizedBox.shrink()),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    HomePage.route(),
                  );
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ), // Change the radius as needed
                  ),
                ),
                child: const Text('Авторизоваться'),
              ),
            ),
          ).paddingSymmetric(horizontal: 20, vertical: 24),
        ],
      ),
    );
  }
}
