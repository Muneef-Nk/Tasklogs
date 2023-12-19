import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/model/todo_model/todo_model.dart';

class TodoScreenController with ChangeNotifier {
  List<TodoModel> todoList = [];
  List<TodoModel> completedList = [];
  List priorityTodo = [];
  var box = Hive.box<TodoModel>('todoBox');
  var boxCompleted = Hive.box<TodoModel>('todoCompletedBox');

//change box value for todolist
  changeCheckValue(int index) {
    todoList[index].isCompleted = true;
    notifyListeners();
  }

  //change box value for completedlist
  changeCheckCompleted(int index) {
    completedList[index].isCompleted = false;
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
  taskCompleted({required int index, required TodoModel todoModel}) async {
    print(todoModel.isCompleted);

    boxCompleted.add(todoModel);
    completedList.add(todoModel);
    box.deleteAt(index);
    getTodo();
    notifyListeners();
  }

//add completed task to new list
  taskInCompleted({required int index, required TodoModel todoModel}) {
    box.add(todoModel);
    todoList.add(todoModel);
    boxCompleted.deleteAt(index);
    getCompltedTask();
    notifyListeners();
  }

  //delete todo
  void deleteTodo(int index) {
    box.deleteAt(index);
    todoList.removeAt(index);
    notifyListeners();
  }

//get completed item to list
  getCompltedTask() async {
    completedList = await boxCompleted.values.toList();
    print(completedList);
    notifyListeners();
  }

//delete completed task
  void deleteCompletedTodo(int index) {
    boxCompleted.deleteAt(index);
    completedList.removeAt(index);
    notifyListeners();
  }
}
