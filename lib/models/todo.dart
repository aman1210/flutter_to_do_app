import 'package:flutter/foundation.dart';

class Todo with ChangeNotifier {
  final String job;
  bool isCompleted;
  final String id;

  Todo({
    @required this.id,
    this.isCompleted = false,
    @required this.job,
  });

  void toggleCompleted() {
    isCompleted = !isCompleted;
    notifyListeners();
  }
}
