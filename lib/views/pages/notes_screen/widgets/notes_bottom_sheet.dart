import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/controller/notes_screen_controller.dart';
import 'package:note_app/model/note_model/data_model.dart';
import 'package:note_app/utils/color_constants/color_constants.dart';
import 'package:provider/provider.dart';

Future<dynamic> bottomSheet(
  BuildContext context,
  int index,
) {
  final provider = Provider.of<NotesScreenController>(context, listen: false);

  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, inBottomSheetsetState) {
          return SizedBox(
            height: 550,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  padding: EdgeInsets.only(left: 20),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    // maxLength: 20,
                    style: TextStyle(color: Colors.white),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                    ],
                    textInputAction: TextInputAction.next,
                    controller: provider.titleController,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: "Title",
                      border: InputBorder.none,
                      // suffixIcon: IconButton(
                      //   onPressed: titleController.clear,
                      //   icon: Icon(Icons.clear),
                      // ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.done,
                    controller: provider.descriptionController,
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Description",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Select background color  : ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: ColorConstants.color.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              inBottomSheetsetState(() {
                                provider.isSelectedColorIndex = index;
                              });
                            },
                            child: index == 0
                                ? Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color(ColorConstants.color[index]),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Center(
                                      child: Text(
                                        "D",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(left: 7),
                                    width: 50,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Color(ColorConstants.color[index]),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:
                                        provider.isSelectedColorIndex == index
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 30,
                                              )
                                            : null,
                                  ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    if (provider.titleController.text.isNotEmpty &&
                        provider.descriptionController.text.isNotEmpty) {
                      Provider.of<NotesScreenController>(
                        context,
                        listen: false,
                      ).addNotes(NoteModel(
                        color: ColorConstants
                            .color[provider.isSelectedColorIndex ?? 0],
                        title: provider.titleController.text,
                        description: provider.descriptionController.text,
                        dateTime:
                            "${provider.selectedDate.day}  - ${provider.selectedDate.month} - ${provider.selectedDate.year}",
                      ));
                      Provider.of<NotesScreenController>(context, listen: false)
                          .getNotes();

                      Navigator.of(context).pop();
                    } else {
                      print("enter somthing");
                    }

                    provider.titleController.clear();
                    provider.descriptionController.clear();

                    provider.isSelectedColorIndex = null;
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      'Save',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    )),
                  ),
                )
              ],
            ),
          );
        });
      });
}
