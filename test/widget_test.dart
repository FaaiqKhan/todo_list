// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:knowunitytodolist/interfaces/all_todo_item_state_interface.dart';
import 'package:knowunitytodolist/models/todo_item_model.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<TodoItemModel>()])
@GenerateMocks([AllTodoItemStateInterface])
import 'widget_test.mocks.dart';

void main() {
  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);
  const String api = 'https://knowunity_case_study.com';
  dioAdapter.onGet(
    api,
    (server) => server.reply(
      200,
      [
        {
          "userId": 1,
          "id": 1,
          "title": "delectus aut autem",
          "completed": false
        }
      ],
      delay: const Duration(seconds: 1),
    ),
  );

  test("Todo api test", () async {
    final response = await dio.get(api);
    final data = response.data as List;
    expect({
      "userId": 1,
      "id": 1,
      "title": "delectus aut autem",
      "completed": false
    }, data.first);
  });

  test("Update todo status", () async {
    final todoItemModel = MockTodoItemModel()
      ..id = 1
      ..userId = 1
      ..title = "Testing"
      ..completed = true;
    MockAllTodoItemStateInterface().updateTodoState(
      todoItemModel.id,
      todoItemModel,
    );
  });
}
