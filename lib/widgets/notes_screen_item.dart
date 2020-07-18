import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import 'package:intl/intl.dart';

import './new_note.dart';

class Note extends StatelessWidget {
  final NoteModel note;

  Note(this.note);

  @override
  Widget build(BuildContext context) {
    // print(note.title);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(NewNote.routeName, arguments: note.id);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        color: Colors.yellow,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      width: 20,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Are You Sure?'),
                            content: Text('Do you want to delete this note?'),
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
                                  Provider.of<Notes>(context, listen: false)
                                      .removeNote(note.id);
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
                  )
                ],
              ),
              Expanded(
                child: Text(
                  note.title.length > 10
                      ? '${note.title.substring(0, 9)}...'
                      : note.title,
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        width: 20,
                      ),
                    ),
                    Icon(
                      Icons.access_time,
                      size: 16,
                    ),
                    Text(DateFormat.yMMMd().format(note.createdDate))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
