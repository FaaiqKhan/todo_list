import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_list/view_models/main_view_model.dart';
import 'package:todo_list/widgets/todo_item.dart';

class IncompleteTodoItemScreen extends ViewModelWidget<MainViewModel> {
  const IncompleteTodoItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.getIncompleteTodos.length,
      itemBuilder: (_, index) {
        return TodoItem(
          key: UniqueKey(),
          viewModel.getIncompleteTodos[index],
          viewModel.updateTodoState,
        );
      },
    );
  }
}
