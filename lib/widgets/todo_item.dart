import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item_model.dart';

class TodoItem extends StatefulWidget {
  const TodoItem(this.model, this.updateTodoList, {Key? key}) : super(key: key);

  final Function updateTodoList;
  final TodoItemModel model;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late bool isTodoCompleted;

  @override
  initState() {
    super.initState();
    isTodoCompleted = widget.model.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.grey.shade100,
      child: CheckboxListTile(
        value: widget.model.completed,
        onChanged: (value) => setState(() {
          isTodoCompleted = value ?? false;
          widget.model.completed = isTodoCompleted;
          widget.updateTodoList(widget.model);
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
