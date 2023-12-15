import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/controller/todo_screen_controller.dart';
import 'package:note_app/views/pages/todo_screen/todos_screen.dart';
import 'package:note_app/views/widgets/floating_buttom.dart';
import 'package:provider/provider.dart';

import '../../../controller/notes_screen_controller.dart';
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
    Provider.of<NotesScreenController>(context, listen: false).getNotes();
    Provider.of<TodoScreenController>(context, listen: false).getTodo();
    super.initState();
  }

  bool isGrid = false;
  int isNotesSeleted = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesScreenController>(context);

    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.amber,
              ),
              Text(
                "muneef",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container()
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(66, 80, 78, 78),
        appBar: appbar(context),
        floatingActionButton: FloatingButtom(),
        body: PageView(
          onPageChanged: (value) {
            isNotesSeleted = value;
            setState(() {});
            print(value);
          },
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  isGrid
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider.noteList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                          title: provider.noteList[index].title,
                                          description: provider
                                              .noteList[index].description,
                                          date:
                                              provider.noteList[index].dateTime,
                                          index: index,
                                          color: Color(
                                              provider.noteList[index].color),
                                        )));
                              },
                              child: NotesCard(
                                index: index,
                                isGrid: isGrid,
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
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: MasonryGridView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: true,
                            itemCount: provider.noteList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            title:
                                                provider.noteList[index].title,
                                            description: provider
                                                .noteList[index].description,
                                            date: provider
                                                .noteList[index].dateTime,
                                            index: index,
                                            color: Color(
                                                provider.noteList[index].color),
                                          )));
                                },
                                child: NotesCard(
                                  isGrid: isGrid,
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
                        ),
                ],
              ),
            ),
            TodoScreen()
          ],
        ));
  }

//commen app bar
  AppBar appbar(BuildContext context) {
    return AppBar(
        backgroundColor: Color.fromARGB(66, 29, 28, 28),
        toolbarHeight: 70,
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            isNotesSeleted == 0 ? "Notes" : "Todo",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        actions: [
          isNotesSeleted == 1
              ? PopupMenuButton(
                  onSelected: (value) {
                    var provider = Provider.of<TodoScreenController>(context);
                    provider.todoList.sort();
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
          isNotesSeleted == 0
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isGrid = !isGrid;
                    });
                  },
                  child: isGrid
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
              Container(
                height: 70,
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[800],
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Search",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white)))),
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
                        setState(() {
                          _pageController.previousPage(
                              duration: Duration(microseconds: 1),
                              curve: Curves.linear);
                        });
                      },
                      child: Container(
                        width: 150,
                        height: 45,
                        decoration: BoxDecoration(
                            color: isNotesSeleted == 0
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
                        _pageController.nextPage(
                            duration: Duration(microseconds: 1),
                            curve: Curves.linear);
                        setState(() {});
                      },
                      child: Container(
                        width: 150,
                        height: 45,
                        decoration: BoxDecoration(
                            color: isNotesSeleted == 1
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
}
