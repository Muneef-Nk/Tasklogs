import 'package:flutter/material.dart';
import 'package:note_app/views/pages/home_screen/widgets/bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_screen_controller.dart';
import '../details_screen/details_screen.dart';
import 'widgets/notes_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeScreenController>(context, listen: false).getNotes();
    super.initState();
  }

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
          bottomSheet(
            context,
            1,
            isUpdate: false,
          );
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
                        color: Color(provider.noteList[index].color),
                      )));
            },
            child: NotesCard(
              index: index,
              title: provider.noteList[index].title,
              des: provider.noteList[index].description,
              date: provider.noteList[index].dateTime,
              color: Color(provider.noteList[index].color),
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
}
