import 'package:flutter/material.dart';
import 'package:note_app/controller/details_screen.dart';
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
    Provider.of<DetailsScreenController>(context, listen: false).seletedColor =
        widget.color;
  }

  @override
  Widget build(BuildContext context) {
    final detailsProvider = Provider.of<DetailsScreenController>(context);
    final provider = Provider.of<NotesScreenController>(context);

    return Scaffold(
      backgroundColor: detailsProvider.seletedColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Provider.of<NotesScreenController>(context, listen: false)
                  .updateNotes(
                      widget.index,
                      NoteModel(
                        color: provider.noteList[widget.index].color,
                        title: _titileController.text,
                        description: _descriptionController.text,
                        dateTime: provider.noteList[widget.index].dateTime,
                      ));

              Provider.of<NotesScreenController>(context, listen: false)
                  .getNotes();

              Provider.of<NotesScreenController>(context, listen: false)
                      .newNoteList =
                  Provider.of<NotesScreenController>(context, listen: false)
                      .noteList;

              setState(() {});

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
          PopupMenuButton(
              onSelected: (value) {
                Provider.of<DetailsScreenController>(context, listen: false)
                    .detailsTools(
                        value,
                        context,
                        _titileController.text,
                        _descriptionController.text,
                        widget.date,
                        widget.color,
                        widget.index);
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.palette_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Change Color",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      value: "Change Color"),
                  PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.delete),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Delete Note",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      value: "Delete Note"),
                  PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.share),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Share",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      value: "Share"),
                ];
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(
                  Icons.sort_sharp,
                  size: 30,
                  color: ColorConstants.white,
                ),
              ))
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
                maxLines: null,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(border: InputBorder.none),
                style: TextStyle(
                    fontSize: 20,
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
                decoration: InputDecoration(border: InputBorder.none),
                maxLines: null,
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
