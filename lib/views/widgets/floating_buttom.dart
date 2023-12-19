import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:note_app/controller/todo_screen_controller.dart';
import 'package:note_app/model/todo_model/todo_model.dart';
import 'package:note_app/views/pages/notes_screen/widgets/notes_bottom_sheet.dart';
import 'package:provider/provider.dart';

class FloatingButtom extends StatefulWidget {
  const FloatingButtom({
    super.key,
  });

  @override
  State<FloatingButtom> createState() => _FloatingButtomState();
}

class _FloatingButtomState extends State<FloatingButtom> {
  String defaultDropdownValue = 'Low priority';
  @override
  void initState() {
    if (selectedValue == null) {
      selectedValue = defaultDropdownValue;
    }
    super.initState();
  }

  TextEditingController _taskController = TextEditingController();
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      overlayColor: Colors.black,
      animatedIcon: AnimatedIcons.menu_close,
      buttonSize: Size(50, 50),
      child: Icon(Icons.add),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      childMargin: EdgeInsets.all(20),
      children: [
        SpeedDialChild(
            onTap: () {
              todoBottomSheet(context);
            },
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            child: Image.asset(
              "assets/icon/todo.png",
              width: 30,
            ),
            label: "Todos"),
        SpeedDialChild(
            onTap: () {
              bottomSheet(
                context,
                1,
              );
            },
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            child: Image.asset(
              "assets/icon/notes.png",
              width: 30,
            ),
            label: "Notes")
      ],
    );
  }

  Future<dynamic> todoBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateSheet) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: 220,
                  color: Colors.black,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _taskController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "Add Your task",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                      DropdownButton(
                          elevation: 0,
                          isDense: false,
                          value: selectedValue,
                          underline: Text(""),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          dropdownColor: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          items: [
                            DropdownMenuItem(
                              enabled: true,
                              value: 'Low priority',
                              child: Text(
                                'Low priority',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Medium priority',
                              child: Text(
                                'Medium priority',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'High priority',
                              child: Text(
                                'High priority',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                          onChanged: (e) {
                            setStateSheet(() {
                              selectedValue = e;
                            });
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_taskController.text.isNotEmpty) {
                            Provider.of<TodoScreenController>(context,
                                    listen: false)
                                .addTodo(TodoModel(
                                    task: _taskController.text,
                                    priority: selectedValue!));

                            Provider.of<TodoScreenController>(context,
                                    listen: false)
                                .getTodo();

                            _taskController.clear();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: 100,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
