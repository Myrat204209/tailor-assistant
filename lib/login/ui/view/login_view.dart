// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/products/products.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton.filled(
              onPressed: () {},
              icon: const Icon(
                Icons.dark_mode_rounded,
                size: 35,
                color: AppColors.secondAccent,
              ),
            ).paddingOnly(right: 20, top: 30),
          ),
          Image.asset(
            'assets/auth.png',
            fit: BoxFit.fill,
          ).paddingOnly(top: 30, right: 45, left: 67),
          AppTextField(
            controller: TextEditingController(),
            hintText: '1234',
            titleText: 'Login',
            // isClose: true,
          ),
          AppTextField(
            controller: TextEditingController(),
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
                    ProductsPage.route(),
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

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    required this.titleText,
    required this.hintText,
    this.isClose = false,
    super.key,
  });

  final bool isClose;
  final TextEditingController controller;
  final String titleText;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: ColoredBox(
            color: AppColors.bgSecond,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      titleText,
                      style: const AppTextStyle.text().lg().regular(),
                    ),
                    if (isClose)
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.close,
                          size: 25,
                          color: AppColors.alertAccent,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                TextField(
                  textAlign: isClose ? TextAlign.end : TextAlign.start,
                  decoration: InputDecoration(
                    hintText: hintText,
                    contentPadding: const EdgeInsets.all(14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                  ),
                ),
              ],
            ).paddingAll(20),
          ),
        ),
        const Divider(
          height: 2,
          color: AppColors.secondAccent,
        ),
      ],
    );
  }
}
