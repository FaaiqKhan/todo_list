import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_list/screens/all_todo_item_screen.dart';
import 'package:todo_list/screens/complete_todo_item_screen.dart';
import 'package:todo_list/screens/incomplete_todo_item_screen.dart';
import 'package:todo_list/view_models/main_view_model.dart';
import 'package:todo_list/widgets/my_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Function addTodo;

  HomeScreen({Key? key}) : super(key: key);

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
                _scaffoldKey.currentState?.showBottomSheet(
                  (context) => MyBottomSheet(addTodo),
                );
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
          child: ViewModelBuilder<MainViewModel>.reactive(
            viewModelBuilder: () => MainViewModel(),
            onModelReady: (viewModel) {
              viewModel.initialize();
              addTodo = viewModel.addTodo;
            },
            builder: (context, mainViewModel, child) {
              return Visibility(
                visible: mainViewModel.isBusy,
                replacement: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TabBarView(
                    children: [
                      AllTodoItemScreen(),
                      IncompleteTodoItemScreen(),
                      CompletedTodoItemScreen(),
                    ],
                  ),
                ),
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}
