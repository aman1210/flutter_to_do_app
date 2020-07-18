import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';
import '../models/todo_provider.dart';
import '../widgets/to_do_item.dart';
import '../widgets/new_job.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    // final _todos = Provider.of<TodoProvider>(context);

    Widget jobList(List<Todo> jobslist) {
      return Container(
        child: Column(children: jobslist.map((job) => Job(job)).toList()),
      );
    }

    void startAddNewJob(ctx) {
      showModalBottomSheet(
          context: ctx,
          isScrollControlled: true,
          builder: (_) {
            return NewJob();
          });
    }

    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: FutureBuilder(
        future:
            Provider.of<TodoProvider>(context, listen: false).fetchAndSetTodo(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: (mediaQuery.size.height - 130),
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.blue.withOpacity(0.3),
                    Colors.amber.withOpacity(0.3),
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                ),
                child: Consumer<TodoProvider>(
                  builder: (context, _todos, child) {
                    return _todos.items.length == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'No jobs added yet!',
                                style: TextStyle(fontSize: 24),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Image.asset(
                                'assests/images/waiting.png',
                                // fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              )
                            ],
                          )
                        : SingleChildScrollView(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                jobList(_todos.uncompleted),
                                jobList(_todos.completed),
                              ],
                            ),
                          );
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewJob(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
