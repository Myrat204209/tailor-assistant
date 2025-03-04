import 'dart:developer';

import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selectedColor = colorScheme.onPrimary;
    final unSelectedColor = colorScheme.primary;
    final selectedIndex = useState(0);
    final pageController = usePageController();

    void onButtonTap(int index) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
      selectedIndex.value = index;
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        log('--------HomePage - PopScope: didPop: $didPop, result: $result');
        if (didPop) {
          return;
        } else {
          await _onWillPop(context);
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                OrdersPage(),
                EmployeesPage(),
                // ReportsPage(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                // width: 260,
                width: 160,
                height: 80,
                child: AnimatedButtonBar(
                  radius: 52,
                  padding: const EdgeInsets.only(right: 5),
                  backgroundColor: selectedColor,
                  foregroundColor: unSelectedColor,
                  children: [
                    _buildButton(
                      icon: Icons.dry_cleaning_rounded,
                      selectedColor: selectedColor,
                      unSelectedColor: unSelectedColor,
                      isSelected: selectedIndex.value == 0,
                      onTap: () => onButtonTap(0),
                    ),
                    _buildButton(
                      icon: Icons.person_3_rounded,
                      selectedColor: selectedColor,
                      unSelectedColor: unSelectedColor,
                      isSelected: selectedIndex.value == 1,
                      onTap: () => onButtonTap(1),
                    ),
                    // _buildButton(
                    //   icon: Icons.notes_rounded,
                    //   selectedColor: selectedColor,
                    //   unSelectedColor: unSelectedColor,
                    //   isSelected: selectedIndex.value == 2,
                    //   onTap: () => onButtonTap(2),
                    // ),
                  ],
                ),
              ).paddingOnly(bottom: 40),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onWillPop(BuildContext context) async {
    await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => const AppDialog(
        buttonText: 'Выход',
        title: 'Вы хотите выйти из приложения?',
        onTap: SystemNavigator.pop,
      ),
    );
  }

  // Button builder
  ButtonBarEntry _buildButton({
    required IconData icon,
    required Color selectedColor,
    required Color unSelectedColor,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return ButtonBarEntry(
      onTap: onTap,
      child: Padding(
        padding: icon == Icons.dry_cleaning_rounded
            ? const EdgeInsets.only(right: 6)
            : const EdgeInsets.only(left:  6),
        child: Icon(
          icon,
          size: 36,
          color: isSelected ? selectedColor : unSelectedColor,
        ),
      ),
    );
  }
}
