
import 'package:data_provider/data_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileState {
  ProfileState({
    required this.products,
    required this.selectedProducts,
  });
  final List<OrderItem> products;
  final List<OrderItem> selectedProducts;

  ProfileState copyWith({
    List<OrderItem>? products,
    List<OrderItem>? selectedProducts,
  }) {
    return ProfileState(
      products: products ?? this.products,
      selectedProducts: selectedProducts ?? this.selectedProducts,
    );
  }
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState(products: [], selectedProducts: []));

  void addProduct(OrderItem product) {
    emit(
      state.copyWith(selectedProducts: [...state.selectedProducts, product]),
    );
  }

  void removeProduct(OrderItem product) {
    final updatedSelected = List<OrderItem>.from(state.selectedProducts)
      ..remove(product);
    emit(state.copyWith(selectedProducts: updatedSelected));
  }

  void clearProduct() {
    final updatedSelected = List<OrderItem>.from(state.selectedProducts)
      ..clear();
    emit(state.copyWith(selectedProducts: updatedSelected));
  }

  void setProducts(List<OrderItem> products) {
    emit(state.copyWith(products: products));
  }
}
