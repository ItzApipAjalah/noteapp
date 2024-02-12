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

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void updateNote(String id, String newTitle, String newDescription) {
  final noteIndex = _notes.indexWhere((note) => note.id == id);
  if (noteIndex != -1) {
    _notes[noteIndex] = Note(
      id: id,
      title: newTitle,
      description: newDescription,
      createdAt: _notes[noteIndex].createdAt,
    );
    notifyListeners();
  }
}

}
