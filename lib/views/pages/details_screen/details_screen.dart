import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/controller/home_screen_controller.dart';
import 'package:note_app/model/data_model.dart';
import 'package:note_app/utils/color_constants/color_constants.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.color,
      required this.index});

  final String title;
  final String description;
  final String date;
  final Color color;
  final int index;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  int? isSelectedColorIndex;

  int? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("Details"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.3),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: () {
                  bottomSheet(context, index: widget.index);
                },
                child: Icon(Icons.edit)),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.white,
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.date,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.description,
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context, {required int index}) {
    final provider = Provider.of<HomeScreenController>(context, listen: false);
    titleController.text = provider.noteList[index].title;
    descriptionController.text = provider.noteList[index].description;
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
                      setState(() {
                        Provider.of<HomeScreenController>(context,
                                listen: false)
                            .updateNotes(
                                index,
                                NoteModel(
                                  color: ColorConstants
                                      .color[isSelectedColorIndex ?? 0],
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
                      Provider.of<HomeScreenController>(context, listen: false)
                          .getNotes();
                      setState(() {});
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        'Update',
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
