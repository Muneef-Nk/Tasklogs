import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String dateTime;
  @HiveField(3)
  final Color color;

  NoteModel({
    required this.color,
    required this.title,
    required this.description,
    required this.dateTime,
  });
}
