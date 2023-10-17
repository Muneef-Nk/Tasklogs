import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../model/data_model.dart';
import '../../../utils/color_constants/color_constants.dart';
import '../details_screen/details_screen.dart';
import 'widgets/notes_card.dart';
// import 'package:hive/hive.dart';

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
    _loadNotes();
    super.initState();
  }

  Future<void> _loadNotes() async {
    final List<NoteModel> notes = await _homeController.getNotes();
    setState(() {
      _homeController.noteList = notes;
    });
  }

  int? isSelectedColorIndex;
  Color? selectedColor;
  DateTime selectedDate = DateTime.now();

  HomeScreenController _homeController = HomeScreenController();
  @override
  Widget build(BuildContext context) {
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
        itemCount: _homeController.noteList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailScreen(
                        title: _homeController.noteList[index].title,
                        description:
                            _homeController.noteList[index].description,
                        date: _homeController.noteList[index].dateTime,
                        color: _homeController.noteList[index].color,
                      )));
            },
            child: NotesCard(
              index: index,
              title: _homeController.noteList[index].title,
              des: _homeController.noteList[index].description,
              date: _homeController.noteList[index].dateTime,
              color: _homeController.noteList[index].color,
              onDelete: () {
                _homeController.deleteNote(index);
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
              height: 500,
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
                          "Select Color : ",
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
                          // physics: const NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          itemCount: ColorConstants.color.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                inBottomSheetsetState(() {
                                  selectedColor = ColorConstants.color[index];
                                  isSelectedColorIndex = index;
                                });
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: ColorConstants.color[index],
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
                      setState(() {
                        _homeController.addNotes(NoteModel(
                          color: selectedColor ?? Colors.black,
                          title: titleController.text,
                          description: descriptionController.text,
                          dateTime:
                              "${selectedDate.day}  - ${selectedDate.month} - ${selectedDate.year}",
                        ));

                        Navigator.of(context).pop();

                        titleController.clear();
                        descriptionController.clear();
                        dateController.clear();
                        isSelectedColorIndex = 20;
                        selectedColor = Colors.black;
                      });
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          color: selectedColor ?? Colors.black,
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
