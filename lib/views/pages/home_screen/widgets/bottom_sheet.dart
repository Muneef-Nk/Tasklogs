import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/controller/home_screen_controller.dart';
import 'package:note_app/model/data_model.dart';
import 'package:note_app/utils/color_constants/color_constants.dart';
import 'package:note_app/views/pages/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

Future<dynamic> bottomSheet(
  BuildContext context,
  int index, {
  required bool isUpdate,
}) {
  final provider = Provider.of<HomeScreenController>(context, listen: false);
  isUpdate
      ? provider.titleController.text = provider.noteList[index].title
      : null;
  isUpdate
      ? provider.descriptionController.text =
          provider.noteList[index].description
      : null;

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
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    // maxLength: 20,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                    ],
                    textInputAction: TextInputAction.next,
                    controller: provider.titleController,
                    decoration: const InputDecoration(
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
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    minLines: 2,
                    maxLines: 10,
                    textInputAction: TextInputAction.done,
                    // keyboardType: TextInputType.multiline,
                    controller: provider.descriptionController,
                    decoration: const InputDecoration(
                        hintText: "Description", border: InputBorder.none),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${provider.selectedDate.day}  - ${provider.selectedDate.month} - ${provider.selectedDate.year}'),
                        GestureDetector(
                            onTap: () async {
                              inBottomSheetsetState(
                                () async {
                                  DateTime? dateTime = await showDatePicker(
                                      context: context,
                                      initialDate: provider.selectedDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2030));
                                  if (dateTime != null) {
                                    inBottomSheetsetState(() {
                                      provider.selectedDate = dateTime;
                                    });
                                  }
                                },
                              );
                            },
                            child: Icon(Icons.calendar_month))
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Select background color  : ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                    height: 25,
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
                                ? CircleAvatar(
                                    backgroundColor:
                                        Color(ColorConstants.color[index]),
                                    radius: 20,
                                    child: Text(
                                      "D",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ))
                                : CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        Color(ColorConstants.color[index]),
                                    child:
                                        provider.isSelectedColorIndex == index
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 20,
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
                      isUpdate
                          ? Provider.of<HomeScreenController>(
                              context,
                              listen: false,
                            ).updateNotes(
                              index,
                              NoteModel(
                                color: ColorConstants
                                    .color[provider.isSelectedColorIndex ?? 0],
                                title: provider.titleController.text,
                                description:
                                    provider.descriptionController.text,
                                dateTime:
                                    "${provider.selectedDate.day}  - ${provider.selectedDate.month} - ${provider.selectedDate.year}",
                              ))
                          : Provider.of<HomeScreenController>(
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

                      isUpdate
                          ? Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false)
                          : Navigator.of(context).pop();
                    } else {
                      print("enter somthing");
                    }

                    provider.titleController.clear();
                    provider.descriptionController.clear();

                    provider.isSelectedColorIndex = null;

                    Provider.of<HomeScreenController>(context, listen: false)
                        .getNotes();
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      isUpdate ? 'Update' : 'Save',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          );
        });
      });
}
