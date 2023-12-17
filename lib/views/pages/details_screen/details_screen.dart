import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:note_app/controller/notes_screen_controller.dart';
import 'package:note_app/model/note_model/data_model.dart';
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
  TextEditingController _titileController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titileController = TextEditingController();
    _descriptionController = TextEditingController();
    _titileController.text = widget.title;
    _descriptionController.text = widget.description;
  }

  bool islisten = false;
  FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    print("clicked");
    try {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      await flutterTts.speak(text);
    } catch (e) {
      print(e);
    }
  }

  stop() {
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesScreenController>(context);
    Color seletedColor = Color(widget.color.value);

    return Scaffold(
      backgroundColor: seletedColor,
      floatingActionButton: islisten
          ? FloatingActionButton(elevation: 0, onPressed: () {})
          : Text(""),
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Provider.of<NotesScreenController>(context, listen: false)
                      .newNoteList =
                  Provider.of<NotesScreenController>(context, listen: false)
                      .noteList;
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
          GestureDetector(
            onTap: () {
              //
            },
            child: Image.asset(
              "assets/icon/picture.png",
              width: 25,
            ),
          ),
          SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              setState(() {
                islisten = !islisten;
              });
            },
            child: Image.asset(
              "assets/icon/voice_search.png",
              width: 25,
            ),
          ),
          SizedBox(width: 15),
          GestureDetector(
            onTap: () {
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
                                      seletedColor =
                                          Color(ColorConstants.color[index]);

                                      Provider.of<NotesScreenController>(
                                              context,
                                              listen: false)
                                          .updateNotes(
                                              index,
                                              NoteModel(
                                                  color: Color(ColorConstants
                                                          .color[index])
                                                      .value,
                                                  title: _titileController.text,
                                                  description:
                                                      _descriptionController
                                                          .text,
                                                  dateTime: widget.date));

                                      Provider.of<NotesScreenController>(
                                              context,
                                              listen: false)
                                          .getNotes();
                                      bottomSetState(() {});

                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      color: Color(ColorConstants.color[index]),
                                      child: seletedColor ==
                                              Color(ColorConstants.color[index])
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              weight: 30,
                                              size: 25,
                                            )
                                          : null,
                                    ),
                                  );
                                }));
                      },
                    );
                  });
            },
            child: Image.asset(
              "assets/icon/theme_color.png",
              width: 25,
            ),
          ),
          SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              speak("muneef");
              // stop();
            },
            child: Image.asset(
              "assets/icon/text-to-speech.png",
              width: 25,
            ),
          ),
          SizedBox(width: 15),
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
              TextField(
                onSubmitted: (value) {
                  Provider.of<NotesScreenController>(context, listen: false)
                      .updateNotes(
                          widget.index,
                          NoteModel(
                            color: widget.color.value,
                            title: _titileController.text,
                            description: widget.description,
                            dateTime: provider.noteList[widget.index].dateTime,
                          ));

                  Provider.of<NotesScreenController>(context, listen: false)
                      .getNotes();
                },
                controller: _titileController,
                decoration: InputDecoration(border: InputBorder.none),
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.date,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  Provider.of<NotesScreenController>(context, listen: false)
                      .updateNotes(
                          widget.index,
                          NoteModel(
                            color: provider.noteList[widget.index].color,
                            title: provider.noteList[widget.index].title,
                            description: _descriptionController.text,
                            dateTime: provider.noteList[widget.index].dateTime,
                          ));

                  Provider.of<NotesScreenController>(context, listen: false)
                      .getNotes();
                },
                maxLines: 1000,
                decoration: InputDecoration(border: InputBorder.none),
                controller: _descriptionController,
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
