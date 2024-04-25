import 'dart:convert';

import 'package:hive/hive.dart';

part 'rating.g.dart';

@HiveType(typeId: 3)
class Rating {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final double rating;

  Rating({required this.userId, required this.rating});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rating': rating,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userId: map['userId'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
}
