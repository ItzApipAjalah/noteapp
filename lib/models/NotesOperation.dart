import 'package:flutter/cupertino.dart';
import 'package:notesapp/models/note.dart';

class NotesOperation with ChangeNotifier {
  //List of note
  List<Note> _notes = [];

  List<Note> get getNotes {
    return _notes;
  }

  NotesOperation() {
    // addNewNote('First Note', 'First Note Description');
  }

void addNewNote(String title, String description, DateTime createdAt) {
 final newNote = Note(
    id: DateTime.now().toString(),
    title: title,
    description: description,
    createdAt: createdAt,
 );

 _notes.add(newNote);
 notifyListeners();
}
}
