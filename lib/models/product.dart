import 'dart:convert';

import 'package:equatable/equatable.dart';
import '../models/rating.dart';

import 'package:hive/hive.dart';

part 'product.g.dart';


@HiveType(typeId: 2)
class Product extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final int quantity;
  @HiveField(3)
  final List<String> images;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final double price;
  @HiveField(6)
  final String? id;
  @HiveField(7)
  final List<Rating>? rating;

  const Product(
      {required this.name,
      required this.description,
      required this.quantity,
      required this.images,
      required this.category,
      required this.price,
      this.id,
      this.rating});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        quantity: map['quantity']?.toInt() ?? 0,
        images: List<String>.from(map['images']),
        category: map['category'] ?? '',
        price: map['price']?.toDouble() ?? 0.0,
        id: map['_id'],
        rating: map['ratings'] != null
            ? List<Rating>.from(
                map['ratings']?.map(
                  (x) => Rating.fromMap(x),
                ),
              )
            : null);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  List<Object?> get props =>
      [name, description, quantity, images, category, price, id, rating];
}
