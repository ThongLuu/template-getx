import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../models/product.dart';

import 'package:hive/hive.dart';

part 'order.g.dart';

@HiveType(typeId: 1)
class Order extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final List<Product> products;
  @HiveField(2)
  final List<int> quantity;
  @HiveField(3)
  final String address;
  @HiveField(4)
  final String userId;
  @HiveField(5)
  final int orderedAt;
  @HiveField(6)
  final int status;
  @HiveField(7)
  final double totalPrice;
  const Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x['product']))),
      quantity: List<int>.from(
        map['products']?.map(
          (x) => x['quantity'],
        ),
      ),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  List<Object?> get props =>
      [id, products, quantity, address, userId, orderedAt, status, totalPrice];
}
