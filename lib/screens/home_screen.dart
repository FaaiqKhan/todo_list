import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item_model.dart';
import 'package:todo_list/screen_states/all_todo_item_state.dart';
import 'package:todo_list/screen_states/global_state.dart';
import 'package:todo_list/screens/all_todo_item_screen.dart';
import 'package:todo_list/screens/complete_todo_item_screen.dart';
import 'package:todo_list/screens/incomplete_todo_item_screen.dart';
import 'package:todo_list/widgets/my_bottom_sheet.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final GlobalState state;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({required this.state, Key? key}) : super(key: key);

  void addTodo(BuildContext context, String todoText) {
    if (todoText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please write todo"),
        ),
      );
    } else {
      state.allTodosItemState.addTodo(TodoItemModel(title: todoText));
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Todo Added")
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("Todo List"),
          actions: [
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const Icon(Icons.add),
              ),
              onTap: () {
                _scaffoldKey.currentState?.showBottomSheet((context) {
                  return MyBottomSheet(addTodo);
                });
              },
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "All"),
              Tab(text: "Incomplete"),
              Tab(text: "Completed"),
            ],
          ),
        ),
        body: SafeArea(
          child: Consumer<AllTodoItemState>(
            builder: (context, todos, child) {
              return Visibility(
                visible: todos.isLoading,
                replacement: child!,
                child: const Center(child: CircularProgressIndicator()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TabBarView(
                children: [
                  AllTodoItemScreen(context),
                  IncompleteTodoItemScreen(context),
                  CompletedTodoItemScreen(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
