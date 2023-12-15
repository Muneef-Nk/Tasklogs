import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note_app/controller/todo_screen_controller.dart';
import 'package:note_app/model/todo_model/todo_model.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoScreenController>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(66, 29, 28, 28),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Pending Task",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.todoList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Slidable(
                      closeOnScroll: true,
                      endActionPane:
                          ActionPane(motion: StretchMotion(), children: [
                        SlidableAction(
                          autoClose: true,
                          onPressed: (e) {
                            Provider.of<TodoScreenController>(context,
                                    listen: false)
                                .deleteTodo(index);
                          },
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        )
                      ]),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 15),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              activeColor: Colors.green,
                              value: provider.todoList[index].isCompleted,
                              side: BorderSide(color: Colors.white, width: 2),
                              onChanged: (bool? newValue) {
                                //check box
                                Provider.of<TodoScreenController>(context,
                                        listen: false)
                                    .changeCheckValue(index);

                                //update check
                                Provider.of<TodoScreenController>(context,
                                        listen: false)
                                    .todoUpdate(
                                  index: index,
                                  todoModel: TodoModel(
                                    task: provider.todoList[index].task,
                                    priority: provider.todoList[index].priority,
                                    isCompleted:
                                        provider.todoList[index].isCompleted,
                                  ),
                                );

                                Provider.of<TodoScreenController>(context,
                                        listen: false)
                                    .getCompltedTask();
                                setState(() {});
                              },
                            ),
                            Text(
                              provider.todoList[index].task,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5, top: 5),
                              decoration: BoxDecoration(
                                  color: provider.todoList[index].priority ==
                                          "Low priority"
                                      ? Colors.red
                                      : provider.todoList[index].priority ==
                                              "Medium priority"
                                          ? Color.fromARGB(255, 208, 191, 37)
                                          : Colors.green,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Text(
                                provider.todoList[index].priority,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Completed Task",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListView.builder(
                itemCount: provider.completedList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Slidable(
                      closeOnScroll: true,
                      endActionPane:
                          ActionPane(motion: StretchMotion(), children: [
                        SlidableAction(
                          autoClose: true,
                          onPressed: (e) {
                            Provider.of<TodoScreenController>(context,
                                    listen: false)
                                .deleteCompletedTodo(index);
                          },
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        )
                      ]),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 15),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              activeColor: Colors.green,
                              value: provider.completedList[index].isCompleted,
                              side: BorderSide(color: Colors.white, width: 2),
                              onChanged: (bool? newValue) {
                                //check box
                                // Provider.of<TodoScreenController>(context,
                                //         listen: false)
                                //     .changeCheckValue(index);

                                //update check
                                // Provider.of<TodoScreenController>(context,
                                //         listen: false)
                                //     .todoUpdate(
                                //   index: index,
                                //   todoModel: TodoModel(
                                //     task: provider.todoList[index].task,
                                //     priority: provider.todoList[index].priority,
                                //     isCompleted:
                                //         provider.todoList[index].isCompleted,
                                //   ),
                                // );
                                // setState(() {});
                              },
                            ),
                            Text(
                              provider.completedList[index].task,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5, top: 5),
                              decoration: BoxDecoration(
                                  color: provider
                                              .completedList[index].priority ==
                                          "Low priority"
                                      ? Colors.red
                                      : provider.todoList[index].priority ==
                                              "Medium priority"
                                          ? Color.fromARGB(255, 208, 191, 37)
                                          : Colors.green,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Text(
                                provider.completedList[index].priority,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
