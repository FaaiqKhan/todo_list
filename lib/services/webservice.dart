import 'package:dio/dio.dart';
import 'package:todo_list/models/todo_item_model.dart';
import 'package:todo_list/utilities/utils.dart';

class WebService {
  late final Dio _dio;

  WebService() {
    _dio = Dio();
    _dio.options.baseUrl = Utils.baseUrl;
    _dio.options.receiveTimeout = 8000;
    _dio.options.connectTimeout = 8000;
  }

  Future<List<TodoItemModel>> getTodos() async {
    List<TodoItemModel> todos = [];
    try {
      final response = await _dio.get('todos');
      if (response.statusCode == 200) {
        final List rawData = response.data;
        todos.addAll(rawData.map((e) => TodoItemModel.fromJson(e)));
      }
    } catch (error) {
      // TODO: print to log error
    }
    return todos;
  }
}
