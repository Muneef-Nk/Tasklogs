import 'package:hive/hive.dart';
import 'package:note_app/core/controller/home_screen_controller.dart';

HomeScreenController homeController = HomeScreenController();

final box = Hive.box('myBox');
void addData() async {
  box.put("notesList", homeController.noteModel);
  print('data list added ');
}

void getData() async {
  List newList = box.get("notesList");

  print(newList);
}
