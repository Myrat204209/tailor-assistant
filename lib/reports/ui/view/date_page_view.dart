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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Backward Button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: currentIndex.value > 0 ? navigateBackward : null,
                  iconSize: 30,
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                  color: Colors.blue,
                  splashColor: Colors.blueAccent,
                ),
                // Date in the center
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    getDateText(currentIndex.value),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Forward Button
                IconButton.filled(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: currentIndex.value < 2 ? navigateForward : null,
                  iconSize: 30,
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                currentIndex.value = index;
              },
              children: const [
                Center(child: Text('Day Before Yesterday')),
                Center(child: Text('Yesterday')),
                Center(child: Text('Today')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
