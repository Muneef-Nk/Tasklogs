import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/model/todo_model/todo_model.dart';

class TodoScreenController with ChangeNotifier {
  List<TodoModel> todoList = [];
  List<TodoModel> completedList = [];
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

  getCompltedTask() async {
    completedList = await boxCompleted.values.toList();
    print(completedList);
    notifyListeners();
  }

  void deleteCompletedTodo(int index) {
    boxCompleted.deleteAt(index);
    completedList.removeAt(index);
    notifyListeners();
  }

  // List lowPriority = [];
  // List mediumPriority = [];
  // List highPriority = [];

  // todoSort(String priority) {
  //   for (int i = 0; i <= todoList.length; i++) {
  //     if (priority == todoList[i].priority) {
  //       lowPriority.add(
  //           TodoModel(task: todoList[i].task, priority: todoList[i].priority));
  //       print("added data low priority");
  //       notifyListeners();
  //     }
  //   }
  //   notifyListeners();
  // }

  void todoSort(String priority) {
    // Implement sorting logic based on priority
    if (priority == 'Low Priority') {
      todoList.sort((a, b) => a.priority.compareTo(b.priority));
    } else if (priority == 'Medium Priority') {
      todoList.sort((a, b) => a.priority.compareTo(b.priority));
    } else if (priority == 'High Priority') {
      todoList.sort((a, b) => a.priority.compareTo(b.priority));
    }
    // Notify listeners to update the UI
    notifyListeners();
  }
}
