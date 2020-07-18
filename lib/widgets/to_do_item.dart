import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';
import '../models/todo_provider.dart';

class Job extends StatelessWidget {
  final Todo job;

  Job(this.job);

  Widget checkIcon(bool isCompleted) {
    if (isCompleted) {
      return Icon(
        Icons.check_circle,
        color: Colors.green,
        // size: 36,
      );
    } else {
      return Icon(Icons.check_circle_outline);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Dismissible(
        key: Key('${job.id}'),
        background: Container(
          color: Colors.red,
          child: Icon(
            Icons.delete_sweep,
            color: Colors.white,
            size: 30,
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Icon(
            Icons.delete_sweep,
            color: Colors.white,
            size: 30,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
        ),
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Are You Sure?'),
                content: Text('Do you want to delete item from the list?'),
                elevation: 20,
                actions: <Widget>[
                  FlatButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    icon: Icon(Icons.clear),
                    label: Text('No'),
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    icon: Icon(Icons.check),
                    label: Text('Yes'),
                  ),
                ],
              );
            },
          );
        },
        onDismissed: (direction) {
          Provider.of<TodoProvider>(context, listen: false).deleteJob(job.id);
        },
        child: ListTile(
          leading: IconButton(
            icon: checkIcon(job.isCompleted),
            onPressed: () {
              Provider.of<TodoProvider>(context, listen: false)
                  .toggleCompleted(job.id);
            },
            splashColor: Colors.green,
          ),
          title: !job.isCompleted
              ? Text(
                  job.job,
                  style: Theme.of(context).textTheme.headline6,
                )
              : Text(
                  job.job,
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                  softWrap: true,
                ),
        ),
      ),
    );
  }
}
