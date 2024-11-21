// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class OrdersModel extends Equatable {
  const OrdersModel({
    required this.orderId,
    required this.orderName,
    required this.orderQuantity,
    required this.orderColors,
    required this.orderTextile,
    required this.startOrder,
    this.orderCollection,
    this.orderVyshyvka,
    this.orderPrint,
  });
  final String startOrder;
  final String? orderId;
  final String? orderName;
  final int? orderQuantity;
  final List<String> orderColors;
  final List<String>? orderCollection;
  final List<String>? orderVyshyvka;
  final List<String> orderTextile;
  final List<String>? orderPrint;

  @override
  List<Object?> get props {
    return [
      orderId,
      orderName,
      orderQuantity,
      orderColors,
      orderCollection,
      orderVyshyvka,
      orderTextile,
      orderPrint,
    ];
  }
}
