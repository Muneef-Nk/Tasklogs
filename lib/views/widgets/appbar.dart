//commen app bar
import 'package:flutter/material.dart';
import 'package:note_app/controller/notes_screen_controller.dart';
import 'package:note_app/controller/todo_screen_controller.dart';
import 'package:note_app/views/pages/note_search/note_search.dart';
import 'package:provider/provider.dart';

AppBar appbar(BuildContext context) {
  final provider = Provider.of<TodoScreenController>(context);
  final noteProvider = Provider.of<NotesScreenController>(context);
  return AppBar(
      backgroundColor: Color.fromARGB(66, 29, 28, 28),
      toolbarHeight: 70,
      elevation: 0,
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          noteProvider.isNotesSeleted == 0 ? "Notes" : "Todo",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      actions: [
        noteProvider.isNotesSeleted == 1
            ? PopupMenuButton(
                onSelected: (value) {
                  Provider.of<TodoScreenController>(context).todoSort(value);
                  print(value);
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Low Priority",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        value: "Low Priority"),
                    PopupMenuItem(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.yellow,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Medium Priority",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        value: "Medium Priority"),
                    PopupMenuItem(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.green,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "High Priority",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        value: "High Priority"),
                  ];
                },
                child: Icon(Icons.sort))
            : Text(''),
        noteProvider.isNotesSeleted == 0
            ? GestureDetector(
                onTap: () {
                  Provider.of<NotesScreenController>(context, listen: false)
                      .changeGridtoList();
                },
                child: noteProvider.isGrid
                    ? Image.asset(
                        "assets/icon/grid.png",
                        width: 30,
                      )
                    : Image.asset(
                        "assets/icon/list.png",
                        width: 30,
                      ))
            : Text(""),
        SizedBox(
          width: 30,
        )
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(135),
        child: Column(
          children: [
            noteProvider.isNotesSeleted == 0
                ? GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NoteSearch())),
                    child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 54, 53, 53),
                            borderRadius: BorderRadius.circular(15)),
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                "search notes title...",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ),
                          ],
                        )),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Total Task ${provider.todoList.length + provider.completedList.length}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "Pending Tasks ${provider.todoList.length}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 70,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      noteProvider.pageController.previousPage(
                          duration: Duration(microseconds: 1),
                          curve: Curves.linear);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                          color: noteProvider.isNotesSeleted == 0
                              ? Colors.white
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icon/notes.png",
                            width: 20,
                          ),
                          Center(
                              child: Text(
                            "NOTES",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      noteProvider.pageController.nextPage(
                          duration: Duration(microseconds: 1),
                          curve: Curves.linear);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                          color: noteProvider.isNotesSeleted == 1
                              ? Colors.white
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icon/todo.png",
                            width: 20,
                          ),
                          Center(
                              child: Text(
                            "TODO",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
}
