import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
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
    final selectedIndex = useState(0);

    // Get theme-aware colors
    final colorScheme = Theme.of(context).colorScheme;
    final selectedColor = colorScheme.primary;
    final unSelectedColor = colorScheme.onPrimary;

    void onPageChange(int index) {
      selectedIndex.value = index;
    }

    void onButtonTap(int index) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
      selectedIndex.value = index;
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        PageView(
          controller: pageController,
          onPageChanged: onPageChange,
          children: const [
            OrdersPage(),
            EmployeesPage(),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 155,
            height: 80,
            child: AnimatedButtonBar(
              controller: AnimatedButtonController(),
              radius: 50,
              backgroundColor: selectedColor,
              foregroundColor: unSelectedColor,
              elevation: 20,
              children: [
                _buildButton(
                  icon: Icons.dry_cleaning_rounded,
                  isSelected: selectedIndex.value == 0,
                  selectedColor: selectedColor,
                  unSelectedColor: unSelectedColor,
                  onTap: () => onButtonTap(0),
                ),
                _buildButton(
                  icon: Icons.person_3_rounded,
                  isSelected: selectedIndex.value == 1,
                  selectedColor: selectedColor,
                  unSelectedColor: unSelectedColor,
                  onTap: () => onButtonTap(1),
                ),
              ],
            ),
          ).paddingOnly(bottom: 40),
        ),
      ],
    );
  }

  ButtonBarEntry _buildButton({
    required IconData icon,
    required bool isSelected,
    required Color selectedColor,
    required Color unSelectedColor,
    required VoidCallback onTap,
  }) {
    return ButtonBarEntry(
      onTap: onTap,
      child: Icon(
        icon,
        size: 35,
        color: isSelected ? selectedColor : unSelectedColor,
      ),
    );
  }
}
