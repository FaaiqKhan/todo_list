import 'package:flutter/material.dart';
import 'package:todo_list/screen_states/all_todo_item_state.dart';
import 'package:todo_list/widgets/todo_item.dart';
import 'package:provider/provider.dart';

class IncompleteTodoItemScreen extends StatelessWidget {
  late final AllTodoItemState _provider;

  IncompleteTodoItemScreen(BuildContext context, {Key? key}) : super(key: key) {
    _provider = Provider.of<AllTodoItemState>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    final incompleteTodos = _provider.getIncompleteTodos;
    return ListView.builder(
      itemCount: incompleteTodos.length,
      itemBuilder: (_, index) {
        return TodoItem(key: UniqueKey(), incompleteTodos[index]);
      },
    );
  }
}
