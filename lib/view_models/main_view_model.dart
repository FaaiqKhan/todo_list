import 'package:stacked/stacked.dart';
import 'package:todo_list/interfaces/all_todo_item_state_interface.dart';
import 'package:todo_list/models/todo_item_model.dart';
import 'package:todo_list/services/hive_service.dart';
import 'package:todo_list/services/webservice.dart';

class MainViewModel extends BaseViewModel implements AllTodoItemStateInterface {
  final List<TodoItemModel> _todos = [];
  final List<TodoItemModel> _incompleteTodos = [];
  final List<TodoItemModel> _completedTodos = [];
  final HiveService _hiveService = HiveService();

  @override
  void setTodos(List<TodoItemModel> todos) {
    _todos.addAll(todos);
    _incompleteTodos.addAll(
      todos.where((element) => element.completed == false),
    );
    _completedTodos.addAll(
      todos.where((element) => element.completed == true),
    );
    notifyListeners();
  }

  @override
  void addTodo(TodoItemModel model) {
    if (_todos.isEmpty) {
      model.id = 0;
      model.userId = 1;
    } else {
      model.id = _todos.last.id! + 1;
      model.userId = 1;
    }
    _todos.add(model);
    _incompleteTodos.add(model);
    _hiveService.storeTodo(model);
    notifyListeners();
  }

  @override
  void updateTodoState(TodoItemModel model) {
    int index = _todos.indexWhere((element) => element.id == model.id);
    _todos[index] = model;
    _hiveService.updateTodoStatus(index, model);
    if (model.completed) {
      _completedTodos.add(model);
      _incompleteTodos.remove(model);
    } else {
      _completedTodos.remove(model);
      _incompleteTodos.add(model);
    }
    notifyListeners();
  }

  List<TodoItemModel> get getTodos => List.from(_todos.reversed.toList());

  List<TodoItemModel> get getIncompleteTodos =>
      List.from(_incompleteTodos.reversed.toList());

  List<TodoItemModel> get getCompletedTodos =>
      List.from(_completedTodos.reversed.toList());

  void initialize() {
    setBusy(true);
    HiveService hiveService = HiveService();
    hiveService.getAllTodos().then((val) {
      if (val.isEmpty) {
        WebService().getTodos().then((value) {
          setTodos(value);
          hiveService.storeTodos(value);
        }).onError((error, stackTrace) {
          // TODO: Print to log error
          setBusy(false);
        }).whenComplete(() => setBusy(false));
      } else {
        setTodos(val);
        setBusy(false);
      }
    });
  }
}
