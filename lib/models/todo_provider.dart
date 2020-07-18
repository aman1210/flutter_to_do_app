import 'package:flutter/foundation.dart';

import './todo.dart';
import '../helpers/todo_db_helper.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _items = [];

  Future<void> fetchAndSetTodo() async {
    final todoDataList = await TodoDBHelper.getData('user_todo');
    _items = todoDataList.map((todo) {
      return Todo(
        id: todo['id'],
        job: todo['job'],
        isCompleted: todo['isCompleted'] == 0 ? false : true,
      );
    }).toList();
    notifyListeners();
  }

  List<Todo> get items {
    return [..._items];
  }

  List<Todo> get completed {
    return _items.where((todo) => todo.isCompleted).toList();
  }

  List<Todo> get uncompleted {
    return _items.where((todo) => todo.isCompleted == false).toList();
  }

  void addJob(String job) {
    final newJob = Todo(id: DateTime.now().toString(), job: job);
    _items.insert(0, newJob);
    notifyListeners();
    TodoDBHelper.insert('user_todo', {
      'id': newJob.id,
      'job': newJob.job,
      'isCompleted': 0,
    });
  }

  void toggleCompleted(String id) {
    final index = _items.indexWhere((element) => element.id == id);
    if (index >= 0) {
      _items[index].isCompleted = !_items[index].isCompleted;
    }
    notifyListeners();
    TodoDBHelper.update(
      'user_todo',
      _items[index].job,
      _items[index].id,
      _items[index].isCompleted == false ? 0 : 1,
    );
  }

  void deleteJob(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    TodoDBHelper.delete(
      'user_todo',
      id,
    );
  }
}
