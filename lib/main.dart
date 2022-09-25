import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/screen_states/global_state.dart';
import 'package:todo_list/screens/home_screen.dart';
import 'package:todo_list/services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().initHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GlobalState globalState = GlobalState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: globalState.allTodosItemState,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(state: globalState),
      ),
    );
  }
}
