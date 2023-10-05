import 'dart:ui';

import 'package:flutter/material.dart';

class NoteModel{
  final String title;
  final String description;
  final DateTime dateTime;
  final Color color;

  NoteModel({required this.color, required this.title, required this.description, required this.dateTime});
}

List<Color> color=[
  Colors.grey.withOpacity(0.3),
  Colors.red,
  Colors.yellow,
  Colors.green,
  Colors.cyan,
  Colors.orange,
  Colors.deepPurpleAccent
];
List<NoteModel> noteModel=[

];
