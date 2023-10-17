import 'package:hive_flutter/adapters.dart';

import '../model/data_model.dart';

class HomeScreenController {
  var _noteBox = Hive.box<List<NoteModel>>('notes');

  List<NoteModel> noteList = [];

  void addNotes(NoteModel newList) {
    noteList.add(newList);
    addData(noteList);
  }

  void deleteNote(int index) {
    noteList.removeAt(index);
    // addData();
    print('data removed');
  }

  getNotes() {
    _noteBox.get('list');
  }

  //add data to database
  void addData(List<NoteModel> noteList) {
    _noteBox.put('list', noteList);
    // _noteBox.put('noteList', noteList);
    print('list added to hive');
  }

  // Future<List<NoteModel>> getNotes() async {
  //   print('hive list get to display');
  //   return _noteBox
  //       .get('list')!
  //       .map(
  //         (e) => NoteModel(
  //           color: e.color,
  //           title: e.title,
  //           description: e.description,
  //           dateTime: e.dateTime,
  //         ),
  //       )
  //       .toList();
  // }
}
