import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:note_app/controller/todo_screen_controller.dart';
import 'package:note_app/model/todo_model/todo_model.dart';
import 'package:note_app/utils/color_constants/color_constants.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    Provider.of<TodoScreenController>(context, listen: false).getCompltedTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoScreenController>(context);
    return Scaffold(
      backgroundColor: Color(ColorConstants.bg1.value),
      body: SingleChildScrollView(
        child: provider.todoList.isEmpty && provider.completedList.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(30),
                child: Lottie.asset('assets/animation/notfound.json'),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  provider.todoList.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Pending Tasks",
                            style: TextStyle(
                                color: ColorConstants.white, fontSize: 20),
                          ),
                        )
                      : Text(""),
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

                                  MotionToast.delete(
                                    height: 120,
                                    position: MotionToastPosition.top,
                                    title: Text("Deletion Successfu"),
                                    description: Text(
                                        "Your task has been deleted successfully. Enjoy a clutter-free workspace!"),
                                  ).show(context);
                                  setState(() {});
                                },
                                icon: Icons.delete,
                                backgroundColor: ColorConstants.red,
                                borderRadius: BorderRadius.circular(15),
                              )
                            ]),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 15, top: 10, bottom: 10),
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: BoxDecoration(
                                  color: ColorConstants.dark,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Checkbox(
                                    activeColor: ColorConstants.green,
                                    value: provider.todoList[index].isCompleted,
                                    side: BorderSide(
                                        color: ColorConstants.white, width: 2),
                                    onChanged: (bool? newValue) {
                                      //check box
                                      Provider.of<TodoScreenController>(context,
                                              listen: false)
                                          .changeCheckValue(index);

                                      //update check
                                      Provider.of<TodoScreenController>(context,
                                              listen: false)
                                          .taskCompleted(
                                        index: index,
                                        todoModel: TodoModel(
                                          task: provider.todoList[index].task,
                                          priority:
                                              provider.todoList[index].priority,
                                          isCompleted: provider
                                              .todoList[index].isCompleted,
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      provider.todoList[index].task,
                                      style: TextStyle(
                                        color: ColorConstants.white,
                                        fontSize: 15,
                                      ),
                                      maxLines: 3,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, bottom: 5, top: 5),
                                    decoration: BoxDecoration(
                                        color:
                                            provider.todoList[index].priority ==
                                                    "Low priority"
                                                ? ColorConstants.red
                                                : provider.todoList[index]
                                                            .priority ==
                                                        "Medium priority"
                                                    ? ColorConstants.yellow
                                                    : ColorConstants.green,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      provider.todoList[index].priority,
                                      style: TextStyle(
                                          color: ColorConstants.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  provider.completedList.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Completed Tasks",
                            style: TextStyle(
                                color: ColorConstants.white, fontSize: 20),
                          ),
                        )
                      : Text(""),
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
                                  MotionToast.delete(
                                    height: 120,
                                    position: MotionToastPosition.top,
                                    title: Text("Deletion Successfu"),
                                    description: Text(
                                        "Your task has been deleted successfully. Enjoy a clutter-free workspace!"),
                                  ).show(context);
                                  setState(() {});
                                },
                                icon: Icons.delete,
                                backgroundColor: ColorConstants.red,
                                borderRadius: BorderRadius.circular(15),
                              )
                            ]),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 15, top: 10, bottom: 10),
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: BoxDecoration(
                                  color: ColorConstants.dark,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Checkbox(
                                    activeColor:
                                        Color.fromARGB(255, 65, 69, 60),
                                    value: provider
                                        .completedList[index].isCompleted,
                                    side: BorderSide(
                                        color: Colors.grey, width: 2),
                                    onChanged: (bool? newValue) {
                                      // check box
                                      Provider.of<TodoScreenController>(context,
                                              listen: false)
                                          .changeCheckCompleted(index);

                                      // update check
                                      Provider.of<TodoScreenController>(context,
                                              listen: false)
                                          .taskInCompleted(
                                        index: index,
                                        todoModel: TodoModel(
                                          task: provider
                                              .completedList[index].task,
                                          priority: provider
                                              .completedList[index].priority,
                                          isCompleted: provider
                                              .completedList[index].isCompleted,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      provider.completedList[index].task,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          decoration:
                                              TextDecoration.lineThrough),
                                      maxLines: 3,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, bottom: 5, top: 5),
                                    decoration: BoxDecoration(
                                        color: provider.completedList[index]
                                                    .priority ==
                                                "Low priority"
                                            ? const Color.fromARGB(
                                                255, 155, 58, 58)
                                            : provider.completedList[index]
                                                        .priority ==
                                                    "Medium priority"
                                                ? Color.fromARGB(
                                                    255, 93, 87, 30)
                                                : Color.fromARGB(
                                                    255, 44, 74, 45),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      provider.completedList[index].priority,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
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
