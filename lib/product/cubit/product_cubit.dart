import 'package:data_provider/data_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileState {
  ProfileState({
    required this.products,
  });
  final List<OrderItem> products;

  ProfileState copyWith({
    List<OrderItem>? products,
  }) {
    return ProfileState(
      products: products ?? this.products,
    );
  }
}

class ProductCubit extends Cubit<ProfileState> {
  ProductCubit() : super(ProfileState(products: []));

  void setProducts(List<OrderItem> products) {
    emit(state.copyWith(products: products));
  }
}
