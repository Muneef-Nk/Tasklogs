import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/controller/notes_screen_controller.dart';
import 'package:note_app/utils/color_constants/color_constants.dart';
import 'package:note_app/views/pages/details_screen/details_screen.dart';
import 'package:note_app/views/pages/notes_screen/widgets/notes_card.dart';
import 'package:provider/provider.dart';

class NoteSearch extends StatefulWidget {
  const NoteSearch({super.key});

  @override
  State<NoteSearch> createState() => _NoteSearchState();
}

class _NoteSearchState extends State<NoteSearch> {
  @override
  void initState() {
    Provider.of<NotesScreenController>(context, listen: false).newNoteList =
        Provider.of<NotesScreenController>(context, listen: false).noteList;
    super.initState();
  }

  TextEditingController _searchQuery = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesScreenController>(context);
    return Scaffold(
        backgroundColor: ColorConstants.bg1,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: MediaQuery.of(context).size.height * 0.1),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 54, 53, 53),
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextField(
                      controller: _searchQuery,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        provider.searchResult =
                            provider.noteList.where((element) {
                          final title = element.title.toLowerCase();
                          final query = value.trim().toLowerCase();
                          return title.contains(query);
                        }).toList();
                        provider.newNoteList = provider.searchResult;
                        setState(() {});
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Search Notes Title",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  )),
              if (provider.newNoteList.isEmpty && _searchQuery.text.isNotEmpty)
                Lottie.asset("assets/animation/notfound.json")
              else
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 10, right: 10, bottom: 10),
                  child: MasonryGridView.builder(
                    shrinkWrap: true,
                    itemCount: provider.newNoteList.length,
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
                                    title: provider.newNoteList[index].title,
                                    description:
                                        provider.newNoteList[index].description,
                                    date: provider.newNoteList[index].dateTime,
                                    index: index,
                                    color: Color(
                                        provider.newNoteList[index].color),
                                  )));
                        },
                        child: NotesCard(
                          isGrid: provider.isGrid,
                          index: index,
                          title: provider.newNoteList[index].title,
                          des: provider.newNoteList[index].description,
                          date: provider.newNoteList[index].dateTime,
                          color: Color(provider.newNoteList[index].color),
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
        ));
  }
}
