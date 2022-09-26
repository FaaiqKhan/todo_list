import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_list/view_models/main_view_model.dart';
import 'package:todo_list/widgets/todo_item.dart';

class AllTodoItemScreen extends ViewModelWidget<MainViewModel> {
  const AllTodoItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.getTodos.length,
      itemBuilder: (_, index) {
        return TodoItem(
          key: UniqueKey(),
          viewModel.getTodos[index],
          viewModel.updateTodoState,
        );
      },
    );
  }
}
