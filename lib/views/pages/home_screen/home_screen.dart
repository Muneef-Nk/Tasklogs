import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../model/data_model.dart';
import '../../../utils/color_constants/color_constants.dart';
import '../details_screen/details_screen.dart';
import 'widgets/notes_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    Provider.of<HomeScreenController>(context, listen: false).getNotes();
    super.initState();
  }

  int? isSelectedColorIndex;
  int? selectedColor;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Notes",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomSheet(context);
        },
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: provider.noteList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailScreen(
                      title: provider.noteList[index].title,
                      description: provider.noteList[index].description,
                      date: provider.noteList[index].dateTime,
                      index: index,
                      color: Color(
                        provider.noteList[index].color,
                      ))));
            },
            child: NotesCard(
              index: index,
              title: provider.noteList[index].title,
              des: provider.noteList[index].description,
              date: provider.noteList[index].dateTime,
              color: provider.noteList[index].color,
              onDelete: () {
                provider.deleteNote(index);
                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
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
                      controller: titleController,
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
                      controller: descriptionController,
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
                              '${selectedDate.day}  - ${selectedDate.month} - ${selectedDate.year}'),
                          GestureDetector(
                              onTap: () async {
                                inBottomSheetsetState(
                                  () async {
                                    DateTime? dateTime = await showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2030));
                                    if (dateTime != null) {
                                      inBottomSheetsetState(() {
                                        selectedDate = dateTime;
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
                                  isSelectedColorIndex = index;
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
                                      child: isSelectedColorIndex == index
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
                    onTap: () {
                      if (titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        setState(() {
                          Provider.of<HomeScreenController>(context,
                                  listen: false)
                              .addNotes(NoteModel(
                            color:
                                ColorConstants.color[isSelectedColorIndex ?? 0],
                            title: titleController.text,
                            description: descriptionController.text,
                            dateTime:
                                "${selectedDate.day}  - ${selectedDate.month} - ${selectedDate.year}",
                          ));

                          Navigator.of(context).pop();

                          titleController.clear();
                          descriptionController.clear();
                          dateController.clear();

                          isSelectedColorIndex = null;
                        });
                        Provider.of<HomeScreenController>(context,
                                listen: false)
                            .getNotes();
                      } else {
                        print('false');
                      }
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        'Save',
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
}
