import 'dart:ui';

import 'package:hive_flutter/hive_flutter.dart';

// part 'color_model.g.dart';

@HiveType(typeId: 2)
class ColorModel {
  @HiveField(0)
  final Color color;

  ColorModel({required this.color});
}
