import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/controller/todo_screen_controller.dart';
import 'package:note_app/views/pages/todo_screen/todos_screen.dart';
import 'package:note_app/views/widgets/appbar.dart';
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
            provider.isNotesSeleted = value;
            setState(() {});
            print(value);
          },
          controller: provider.pageController,
          scrollDirection: Axis.horizontal,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  provider.isGrid
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
                                setState(() {});
                              },
                              child: NotesCard(
                                index: index,
                                isGrid: provider.isGrid,
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
                                  isGrid: provider.isGrid,
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
}
