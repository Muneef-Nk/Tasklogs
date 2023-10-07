import '../model/data_model.dart';

class HomeScreenController {
  List<NoteModel> noteModel = [];

  void addNotes(NoteModel newModel) {
    noteModel.add(newModel);
  }

  void deleteNote(int index) {
    noteModel.removeAt(index);
  }
}
