import 'package:flutter/material.dart';
import 'package:knowunitytodolist/screen_states/all_todo_item_state.dart';
import 'package:knowunitytodolist/widgets/todo_item.dart';
import 'package:provider/provider.dart';

class CompletedTodoItemScreen extends StatelessWidget {
  late final AllTodoItemState _provider;

  CompletedTodoItemScreen(BuildContext context, {Key? key}) : super(key: key) {
    _provider = Provider.of<AllTodoItemState>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    final completedTodos = _provider.getCompletedTodos;
    return ListView.builder(
      itemCount: completedTodos.length,
      itemBuilder: (_, index) {
        return TodoItem(key: UniqueKey(), completedTodos[index]);
      },
    );
  }
}