import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/model/note_model/data_model.dart';

class NotesScreenController with ChangeNotifier {
  var box = Hive.box<NoteModel>('notesBox');

  List<NoteModel> noteList = [];
  List<NoteModel> newNoteList = [];

  int? isSelectedColorIndex;
  int? selectedColor;
  DateTime selectedDate = DateTime.now();

  bool isGrid = false;
  int isNotesSeleted = 0;
  PageController pageController = PageController();
  List<NoteModel> searchResult = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  //changeGridtoList
  changeGridtoList() {
    isGrid = !isGrid;
    notifyListeners();
  }

//add notes
  void addNotes(NoteModel noteModel) async {
    await box.add(noteModel);
    notifyListeners();
  }

//delete notes
  void deleteNote(int index) {
    noteList.removeAt(index);
    box.deleteAt(index);
  }

//get notes
  getNotes() async {
    noteList = await box.values.toList();
    notifyListeners();
  }

//update notes
  updateNotes(int index, NoteModel noteModel) async {
    print("data updated");
    await box.putAt(index, noteModel);
    notifyListeners();
  }
}
