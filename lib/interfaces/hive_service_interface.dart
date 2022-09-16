import 'package:knowunitytodolist/models/todo_item_model.dart';

abstract class HiveServiceInterface {
  Future<List<TodoItemModel>> getAllTodos();
  Future<bool> updateTodoStatus(int todoId, TodoItemModel updatedTodo);
  Future<bool> storeTodos(List<TodoItemModel> todos);
  Future<bool> storeTodo(TodoItemModel todo);
}