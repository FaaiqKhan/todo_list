import 'package:knowunitytodolist/screen_states/all_todo_item_state.dart';
import 'package:knowunitytodolist/services/hive_service.dart';
import 'package:knowunitytodolist/services/webservice.dart';

class GlobalState {
  late final AllTodoItemState _allTodoItemState;

  GlobalState() {
    _allTodoItemState = AllTodoItemState();
    HiveService hiveService = HiveService();
    hiveService.getAllTodos().then((val) {
      if (val.isEmpty) {
        WebService().getTodos().then((value) {
          _allTodoItemState.setTodos(value);
          hiveService.storeTodos(value);
        }).onError((error, stackTrace) {
          // TODO: Print to log error
        }).whenComplete(() => _allTodoItemState.setBusy(value: false));
      } else {
        _allTodoItemState.setTodos(val);
        _allTodoItemState.setBusy(value: false);
      }
    });
  }

  AllTodoItemState get allTodosItemState => _allTodoItemState;
}