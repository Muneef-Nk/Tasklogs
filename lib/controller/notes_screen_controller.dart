import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/model/note_model/data_model.dart';

class NotesScreenController with ChangeNotifier {
  List<NoteModel> noteList = [];
  var box = Hive.box<NoteModel>('notesBox');
  int? isSelectedColorIndex;
  int? selectedColor;
  DateTime selectedDate = DateTime.now();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void addNotes(NoteModel noteModel) async {
    // noteList.add(newList);
    await box.add(noteModel);
    notifyListeners();
  }

  void deleteNote(int index) {
    noteList.removeAt(index);
    box.deleteAt(index);
  }

  getNotes() async {
    noteList = await box.values.toList();
    notifyListeners();
  }

  updateNotes(int index, NoteModel noteModel) async {
    await box.putAt(index, noteModel);
    notifyListeners();
  }
}
