import 'package:flutter/material.dart';

class NoteModel {
  final String title;
  final String description;
  final String dateTime;
  final Color color;

  NoteModel({
    required this.color,
    required this.title,
    required this.description,
    required this.dateTime,
  });
}
