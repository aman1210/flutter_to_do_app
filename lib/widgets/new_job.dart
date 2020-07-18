import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo_provider.dart';

class NewJob extends StatelessWidget {
  final jobController = TextEditingController();

  void _submitData(BuildContext context) {
    if (jobController.text.isEmpty) {
      return;
    }
    print(jobController.text);
    Provider.of<TodoProvider>(context, listen: false)
        .addJob(jobController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Job',
                ),
                controller: jobController,
                onSubmitted: (_) => _submitData(context),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                padding: EdgeInsets.all(10),
                elevation: 10,
                child: Text('Add'),
                color: Theme.of(context).accentColor,
                onPressed: () => _submitData(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
