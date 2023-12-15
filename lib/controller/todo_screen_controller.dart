import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/model/todo_model/todo_model.dart';

class TodoScreenController with ChangeNotifier {
  List<TodoModel> todoList = [];
  List<TodoModel> completedList = [];
  var box = Hive.box<TodoModel>('todoBox');
  var boxCompleted = Hive.box<TodoModel>('todoCompletedBox');

//change check box value
  changeCheckValue(int index) {
    todoList[index].isCompleted = !todoList[index].isCompleted;
    notifyListeners();
  }

//add todo
  void addTodo(TodoModel todoModel) async {
    await box.add(todoModel);
    print("added ");
    notifyListeners();
  }

//get todo data
  void getTodo() async {
    todoList = await box.values.toList();
    notifyListeners();
  }

//update todo
  todoUpdate({required int index, required TodoModel todoModel}) async {
    // await box.putAt(index, todoModel);

    await boxCompleted.add(todoModel);
    // completedList.add(todoModel);

    box.deleteAt(index);

    getTodo();
    notifyListeners();
  }

  //delete todo
  void deleteTodo(int index) {
    box.deleteAt(index);
    todoList.removeAt(index);
    notifyListeners();
  }

  getCompltedTask() async {
    completedList = await boxCompleted.values.toList();
    notifyListeners();
  }

  void deleteCompletedTodo(int index) {
    boxCompleted.deleteAt(index);
    completedList.removeAt(index);
    notifyListeners();
  }
}
