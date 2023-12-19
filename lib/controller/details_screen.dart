import 'package:flutter/material.dart';
import 'package:note_app/controller/notes_screen_controller.dart';
import 'package:note_app/model/note_model/data_model.dart';
import 'package:note_app/utils/color_constants/color_constants.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class DetailsScreenController with ChangeNotifier {
  Color seletedColor = Colors.transparent;

  void detailsTools(String menuItem, BuildContext context, String title,
      String desc, String date, Color color, int seletedIndex) {
    if (menuItem == "Change Color") {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, bottomSetState) {
              return Container(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ColorConstants.color.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        seletedColor = Color(ColorConstants.color[index]);

                        Provider.of<NotesScreenController>(context,
                                listen: false)
                            .updateNotes(
                          seletedIndex,
                          NoteModel(
                            color: seletedColor.value,
                            title: title,
                            description: desc,
                            dateTime: date,
                          ),
                        );

                        notifyListeners(); // Notify listeners after updating color

                        Provider.of<NotesScreenController>(context,
                                listen: false)
                            .getNotes();
                        bottomSetState(() {});
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Color(ColorConstants.color[index]),
                        child:
                            seletedColor == Color(ColorConstants.color[index])
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    weight: 30,
                                    size: 25,
                                  )
                                : null,
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      );
    } else if (menuItem == "Delete Note") {
      Provider.of<NotesScreenController>(context, listen: false)
          .deleteNote(seletedIndex);

      Provider.of<NotesScreenController>(context, listen: false).getNotes();
      Navigator.of(context).pop();
      notifyListeners();
    } else if (menuItem == "Share") {
      Share.share('Title: ${title},\n Description: ${desc}');
      notifyListeners();
    }
  }
}
