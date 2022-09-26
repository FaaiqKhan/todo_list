import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/interfaces/hive_service_interface.dart';
import 'package:todo_list/models/todo_item_model.dart';

class HiveService implements HiveServiceInterface {
  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoItemModelAdapter());
  }

  @override
  Future<List<TodoItemModel>> getAllTodos() async {
    final todosBox = await Hive.openBox<TodoItemModel>("allTodos");
    final List<TodoItemModel> todos = todosBox.values.toList();
    await todosBox.close();
    return todos;
  }

  @override
  Future<bool> updateTodoStatus(int index, TodoItemModel updatedTodo) async {
    try {
      final todosBox = await Hive.openBox<TodoItemModel>("allTodos");
      await todosBox.putAt(index, updatedTodo);
      await todosBox.close();
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> storeTodos(List<TodoItemModel> todos) async {
    try {
      final todosBox = await Hive.openBox<TodoItemModel>("allTodos");
      await todosBox.putAll(todos.asMap());
      await todosBox.close();
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> storeTodo(TodoItemModel todo) async {
    try {
      final todosBox = await Hive.openBox<TodoItemModel>("allTodos");
      await todosBox.add(todo);
      await todosBox.close();
      return true;
    } catch (error) {
      return false;
    }
  }


}
