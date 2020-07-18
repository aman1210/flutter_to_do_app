import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../widgets/note_paint.dart';

class NewNote extends StatefulWidget {
  static const routeName = '/new-note';

  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final _textFocusNode = FocusNode();
  var titleController = TextEditingController();
  var _dataSubmit = false;
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _editNote = NoteModel(
    id: null,
    title: '',
    notes: '',
    createdDate: DateTime.now(),
  );
  var _initValues = {'title': '', 'notes': ''};

  @override
  void dispose() async {
    super.dispose();
    _textFocusNode.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      final noteId = ModalRoute.of(context).settings.arguments as String;
      if (noteId != null) {
        _editNote = Provider.of<Notes>(context, listen: false).findById(noteId);
        _initValues = {
          'title': _editNote.title,
          'notes': _editNote.notes,
        };
      }
    }
    titleController.text = _editNote.title;
    _isInit = false;
    super.didChangeDependencies();
  }

  void _submitData() {
    final _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState.save();
    if (titleController.text != '') {
      if (_editNote.id == null) {
        Provider.of<Notes>(context, listen: false).addNote(_editNote);
      } else {
        Provider.of<Notes>(context, listen: false).updateNote(_editNote);
      }
      _dataSubmit = true;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _editNote.id == null ? Text('New Note') : Text('Edit Note'),
      ),
      resizeToAvoidBottomPadding: false,
      body: WillPopScope(
        onWillPop: () {
          if (_dataSubmit) {
            return;
          }
          _submitData();
          return;
        },
        child: Stack(children: [
          Pp(),
          Container(
            child: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelText: "Heading",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        errorStyle: TextStyle(fontSize: 14),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      controller: titleController,
                      // initialValue: _initValues['title'],
                      onSaved: (newValue) {
                        _editNote = NoteModel(
                          id: _editNote.id,
                          title: newValue,
                          notes: _editNote.notes,
                          createdDate: DateTime.now(),
                        );
                      },
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_textFocusNode);
                      },
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      DateFormat.yMMMd().add_jm().format(DateTime.now()),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 20),
                      initialValue: _initValues['notes'],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Text",
                        focusColor: Colors.white,
                        errorStyle: TextStyle(fontSize: 14),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 15,
                      focusNode: _textFocusNode,
                      onSaved: (newValue) {
                        _editNote = NoteModel(
                          id: _editNote.id,
                          notes: newValue,
                          title: _editNote.title,
                          createdDate: _editNote.createdDate,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _submitData();
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
