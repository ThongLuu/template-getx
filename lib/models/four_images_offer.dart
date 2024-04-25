// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:hive/hive.dart';

part 'four_images_offer.g.dart';

@HiveType(typeId: 0)
class FourImagesOffer extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final List<String> images;
  @HiveField(3)
  final List<String> labels;
  @HiveField(4)
  final String category;

  const FourImagesOffer(
      {this.id,
      required this.title,
      required this.images,
      required this.labels,
      required this.category});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'images': images,
      'labels': labels,
      'category': category,
    };
  }

  factory FourImagesOffer.fromMap(Map<String, dynamic> map) {
    return FourImagesOffer(
      id: map['_id'] as String,
      title: map['title'] as String,
      images: List<String>.from((map['images'])),
      labels: List<String>.from((map['labels'])),
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FourImagesOffer.fromJson(String source) =>
      FourImagesOffer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  FourImagesOffer copyWith({
    String? id,
    String? title,
    List<String>? images,
    List<String>? labels,
    String? category,
  }) {
    return FourImagesOffer(
      id: id ?? this.id,
      title: title ?? this.title,
      images: images ?? this.images,
      labels: labels ?? this.labels,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [id, title, images, labels, category];
}
