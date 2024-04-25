import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 6)
class User extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String address;
  @HiveField(5)
  final String type;
  @HiveField(6)
  final String token;
  @HiveField(7)
  final List<dynamic> cart;
  @HiveField(8)
  final List<dynamic> saveForLater;
  @HiveField(9)
  final List<dynamic> keepShoppingFor;
  @HiveField(10)
  final List<dynamic> wishList;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
    required this.saveForLater,
    required this.keepShoppingFor,
    required this.wishList,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
      'saveForLater': saveForLater,
      'keepShoppingFor': keepShoppingFor,
      'wishList': wishList,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      saveForLater: List<Map<String, dynamic>>.from(
        map['saveForLater']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      keepShoppingFor: List<Map<String, dynamic>>.from(
        map['keepShoppingFor']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      wishList: List<Map<String, dynamic>>.from(
        map['wishList']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
    List<dynamic>? saveForLater,
    List<dynamic>? keepShoppingFor,
    List<dynamic>? wishList,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
      saveForLater: saveForLater ?? this.saveForLater,
      keepShoppingFor: keepShoppingFor ?? this.keepShoppingFor,
      wishList: wishList ?? this.wishList,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        password,
        address,
        type,
        token,
        cart,
        saveForLater,
        keepShoppingFor,
        wishList
      ];
}
