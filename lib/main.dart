import 'package:flutter/material.dart';
import 'package:note_app/controller/todo_screen_controller.dart';
import 'package:note_app/model/note_model/data_model.dart';
import 'package:note_app/model/todo_model/todo_model.dart';
import 'package:provider/provider.dart';

import 'controller/notes_screen_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'views/pages/notes_screen/notes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(TodoModelAdapter());

  await Hive.initFlutter();
  await Hive.openBox<NoteModel>('notesBox');
  await Hive.openBox<TodoModel>('todoBox');
  await Hive.openBox<TodoModel>('todoCompletedBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesScreenController()),
        ChangeNotifierProvider(create: (context) => TodoScreenController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: "poppins",
            bottomSheetTheme:
                BottomSheetThemeData(backgroundColor: Colors.black)),
        home: HomeScreen(),
      ),
    );
  }
}
