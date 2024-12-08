import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DatePageView extends HookWidget {
  const DatePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentIndex = useState(0);

    String getDateText(int index) {
      final currentDate = DateTime.now();
      DateTime targetDate;

      switch (index) {
        case 1:
          targetDate =
              currentDate.subtract(const Duration(days: 1)); // Yesterday
        case 2:
          targetDate = currentDate
              .subtract(const Duration(days: 2)); // Day before yesterday
        default:
          targetDate = currentDate; // Today
          break;
      }

      return "${targetDate.day.toString()..padLeft(2, '0')}.${targetDate.month..toString().padLeft(2, '0')}.${targetDate.year}";
    }

    // Handle Forward and Backward button presses
    void navigateForward() {
      if (currentIndex.value < 2) {
        currentIndex.value++;
        pageController.animateToPage(
          currentIndex.value,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    void navigateBackward() {
      if (currentIndex.value > 0) {
        currentIndex.value--;
        pageController.animateToPage(
          currentIndex.value,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Date Navigation'),
        ),
        body: const Column());
  }
}
