import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
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
