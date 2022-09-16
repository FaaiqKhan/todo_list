import 'package:flutter/material.dart';
import 'package:knowunitytodolist/interfaces/all_todo_item_state_interface.dart';
import 'package:knowunitytodolist/models/todo_item_model.dart';
import 'package:knowunitytodolist/services/hive_service.dart';

class AllTodoItemState extends ChangeNotifier implements AllTodoItemStateInterface {
  bool _isLoading = true;
  final List<TodoItemModel> _todos = [];
  final HiveService _hiveService = HiveService();

  @override
  void setTodos(List<TodoItemModel> todos) {
    _todos.addAll(todos);
    notifyListeners();
  }

  @override
  void addTodo(TodoItemModel model) {
    final updatedModel = model
      ..id = _todos.last.id! + 1
      ..userId = 1;
    _todos.add(updatedModel);
    _hiveService.storeTodo(updatedModel);
    notifyListeners();
  }

  void setBusy({bool value = true}) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void updateTodoState(int id, TodoItemModel model) {
    _todos[_todos.indexWhere((element) => element.id == id)] = model;
    _hiveService.updateTodoStatus(id, model);
    notifyListeners();
  }

  List<TodoItemModel> get getTodos => List.from(_todos.reversed.toList());

  List<TodoItemModel> get getIncompleteTodos => List.from(
      _todos.reversed.toList().where((element) => element.completed == false));

  List<TodoItemModel> get getCompletedTodos => List.from(
      _todos.reversed.toList().where((element) => element.completed == true));

  bool get isLoading => _isLoading;
}
