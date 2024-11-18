import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'products_view.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProductsView(),
    );
  }
}
