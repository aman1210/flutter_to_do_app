import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/notes_screen_item.dart';
import '../models/note.dart';
import '../widgets/new_note.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<Notes>(context, listen: false).fetchAndSetNotes(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<Notes>(
                    builder: (context, _notesList, child) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.yellow.withOpacity(0.3),
                              Colors.green.withOpacity(0.3),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: _notesList.items.length == 0
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Add Note',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black54),
                                  ),
                                  Icon(
                                    Icons.note,
                                    size: 100,
                                    color: Colors.black54,
                                  ),
                                ],
                              )
                            : GridView(
                                padding: EdgeInsets.all(25),
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  childAspectRatio: 5 / 4,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                children: _notesList.items.map(
                                  (note) {
                                    return Note(note);
                                  },
                                ).toList(),
                              ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).pushNamed(NewNote.routeName);
        },
      ),
    );
  }
}
