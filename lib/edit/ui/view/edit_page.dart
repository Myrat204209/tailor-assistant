import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/edit/edit.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
    context.read<OperationBloc>().add(const OperationRequested());
    return const Scaffold(
      body: EditView(),
    );
  }
}
