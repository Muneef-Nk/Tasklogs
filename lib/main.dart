import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/model/data_model.dart';
import 'core/views/pages/home_screen/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  Hive.openBox<List<NoteModel>>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
