import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileState {
  ProfileState({
    required this.products,
    required this.selectedProducts,
  });
  final List<String> products;
  final List<String> selectedProducts;

  ProfileState copyWith({
    List<String>? products,
    List<String>? selectedProducts,
  }) {
    return ProfileState(
      products: products ?? this.products,
      selectedProducts: selectedProducts ?? this.selectedProducts,
    );
  }
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState(products: [], selectedProducts: []));

  void addProduct(String product) {
    final updatedSelected = List<String>.from(state.selectedProducts)
      ..add(product);
    emit(state.copyWith(selectedProducts: updatedSelected));
  }

  void removeProduct(String product) {
    final updatedSelected = List<String>.from(state.selectedProducts)
      ..remove(product);
    emit(state.copyWith(selectedProducts: updatedSelected));
  }
  void clearProduct() {
    final updatedSelected = List<String>.from(state.selectedProducts)
      ..clear();
    emit(state.copyWith(selectedProducts: updatedSelected));
  }

  void setProducts(List<String> products) {
    emit(state.copyWith(products: products));
  }
}
