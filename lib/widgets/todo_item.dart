import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item_model.dart';
import 'package:todo_list/screen_states/all_todo_item_state.dart';
import 'package:provider/provider.dart';

class TodoItem extends StatefulWidget {
  const TodoItem(this.model, {Key? key}) : super(key: key);

  final TodoItemModel model;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late bool isTodoCompleted;
  late AllTodoItemState _provider;

  @override
  initState() {
    super.initState();
    isTodoCompleted = widget.model.completed;
    _provider = Provider.of<AllTodoItemState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.grey.shade100,
      child: CheckboxListTile(
        value: isTodoCompleted,
        onChanged: (value) => setState(() {
          isTodoCompleted = value ?? false;
          _provider.updateTodoState(
            widget.model.id!,
            widget.model..completed = isTodoCompleted,
          );
        }),
        title: Text(
          widget.model.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
