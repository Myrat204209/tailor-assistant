import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/edit/edit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

part 'profile_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProfileView(),
    );
  }
}
