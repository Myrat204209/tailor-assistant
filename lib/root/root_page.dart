// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/products/products.dart';
import 'package:dap_foreman_assis/sewers/sewers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  const HomePage({
    super.key,
  });
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView(
          controller: pageController,
          children: const [
            ProductsPage(),
            SewersPage(),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 155,
            height: 80,
            child: AnimatedButtonBar(
              radius: 50,
              backgroundColor: AppColors.secondAccent,
              foregroundColor: AppColors.mainAccent,
              elevation: 20,
              children: [
                ButtonBarEntry(
                  onTap: () => pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  ),
                  child: const Icon(
                    Icons.dry_cleaning_rounded,
                    size: 35,
                    color: AppColors.mainAccent,
                  ),
                ),
                ButtonBarEntry(
                  onTap: () => pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  ),
                  child: const Icon(
                    Icons.person_3_rounded,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ).paddingOnly(bottom: 40),
        ),
      ],
    );
  }
}
