import 'package:hive_flutter/hive_flutter.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 2)
class TodoModel {
  @HiveField(0)
  bool isCompleted;
  @HiveField(1)
  final String task;
  @HiveField(2)
  final String priority;

  TodoModel(
      {this.isCompleted = false, required this.task, required this.priority});
}
