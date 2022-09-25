import 'package:todo_list/models/todo_item_model.dart';

abstract class AllTodoItemStateInterface {
  void setTodos(List<TodoItemModel> todos);
  void addTodo(TodoItemModel model);
  void updateTodoState(int id, TodoItemModel model);
}