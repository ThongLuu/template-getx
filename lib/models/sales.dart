import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../utils/constants/constants.dart';

import 'package:hive/hive.dart';

part 'sales.g.dart';

@HiveType(typeId: 4)
class Sales extends Equatable {
  @HiveField(0)
  final String label;
  @HiveField(1)
  final int earning;
  final Color pointColor = Constants.secondaryColor;

  const Sales(this.label, this.earning);

  @override
  List<Object?> get props => [label, earning, pointColor];
}
