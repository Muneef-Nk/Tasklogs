import 'package:flutter/material.dart';
import 'package:note_app/views/pages/notes_screen/widgets/notes_bottom_sheet.dart';

class DetailScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.withOpacity(0.9),
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("Details"),
        leading: Padding(
          padding: EdgeInsets.all(8.0),
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
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: () {
                  bottomSheet(
                    context,
                    isUpdate: true,
                    index,
                  );
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
              Text(
                title,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              // Divider(
              //   color: Colors.white,
              //   thickness: 2,
              // ),
              SizedBox(
                height: 10,
              ),
              Text(
                date,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                description,
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
