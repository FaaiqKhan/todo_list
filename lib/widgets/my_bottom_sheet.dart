import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item_model.dart';

class MyBottomSheet extends StatelessWidget {
  MyBottomSheet(this.addTodo, {Key? key}) : super(key: key);

  final Function addTodo;
  final _todoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      child: Card(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _todoTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your Todo",
                ),
              ),
            ),
            ElevatedButton(
              child: const Text("Add Todo"),
              onPressed: () {
                if (_todoTextController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please write todo"),
                    ),
                  );
                } else {
                  addTodo(
                    TodoItemModel(title: _todoTextController.text),
                  );
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Todo Added")),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
