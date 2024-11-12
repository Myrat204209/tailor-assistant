import 'package:app_ui/app_ui.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

part 'edit_view.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (context) => const EditPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EditView(),
    );
  }
}
