import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0; 

  // Get theme-aware colors
  late Color selectedColor;
  late Color unSelectedColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final colorScheme = Theme.of(context).colorScheme;
    selectedColor = colorScheme.onPrimary;
    unSelectedColor = colorScheme.primary;
  }

  // Handle page changes and button tap actions
  void onPageChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onButtonTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: onPageChange,
          children: const [
            OrdersPage(),
            EmployeesPage(),
            ReportsPage(),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 250,
            height: 80,
            child: AnimatedButtonBar(
              radius: 50,
              backgroundColor: selectedColor,
              foregroundColor: unSelectedColor,
              children: [
                _buildButton(
                  icon: Icons.dry_cleaning_rounded,
                  index: 0,
                  selectedColor: selectedColor,
                  unSelectedColor: unSelectedColor,
                  onTap: () => onButtonTap(0),
                ),
                _buildButton(
                  icon: Icons.person_3_rounded,
                  index: 1,
                  selectedColor: selectedColor,
                  unSelectedColor: unSelectedColor,
                  onTap: () => onButtonTap(1),
                ),
                _buildButton(
                  icon: Icons.notes_rounded,
                  index: 2,
                  selectedColor: selectedColor,
                  unSelectedColor: unSelectedColor,
                  onTap: () => onButtonTap(2),
                ),
              ],
            ),
          ).paddingOnly(bottom: 40),
        ),
      ],
    );
  }

  // Button builder
  ButtonBarEntry _buildButton({
    required IconData icon,
    required int index,
    required Color selectedColor,
    required Color unSelectedColor,
    required VoidCallback onTap,
  }) {
    final isSelected = _selectedIndex == index;

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
