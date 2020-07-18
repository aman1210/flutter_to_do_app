import 'package:flutter/material.dart';

import '../helpers/notes_db_helper.dart';

class NoteModel {
  final String id;
  final String title;
  final String notes;
  final DateTime createdDate;

  NoteModel({
    @required this.id,
    @required this.title,
    @required this.notes,
    @required this.createdDate,
  });
}

class Notes with ChangeNotifier {
  List<NoteModel> _items = [];

  List<NoteModel> get items {
    return [..._items];
  }

  NoteModel findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetNotes() async {
    final notes = await NotesDBHelper.getData('user_notes');
    _items = notes.map((note) {
      return NoteModel(
        id: note['id'],
        title: note['title'],
        notes: note['notes'],
        createdDate: DateTime.parse(note['createdDate']),
      );
    }).toList();
    notifyListeners();
  }

  void addNote(NoteModel newNote) {
    final newNoteDetail = NoteModel(
      id: DateTime.now().toString(),
      title: newNote.title,
      notes: newNote.notes,
      createdDate: newNote.createdDate,
    );
    _items.add(newNoteDetail);
    notifyListeners();
    NotesDBHelper.insert('user_notes', {
      'id': newNoteDetail.id,
      'title': newNoteDetail.title,
      'notes': newNoteDetail.notes,
      'createdDate': newNoteDetail.createdDate.toIso8601String(),
    });
  }

  void updateNote(NoteModel updatedNote) {
    final index = _items.indexWhere((element) => element.id == updatedNote.id);
    _items[index] = updatedNote;
    notifyListeners();
    NotesDBHelper.update(
      'user_notes',
      updatedNote.id,
      updatedNote.title,
      updatedNote.notes,
      updatedNote.createdDate.toIso8601String(),
    );
  }

  void removeNote(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    NotesDBHelper.delete('user_notes', id);
  }
}
