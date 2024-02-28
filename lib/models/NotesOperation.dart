import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notesapp/models/note.dart';

class NotesOperation with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get getNotes {
    return _notes;
  }

  NotesOperation() {
    _loadNotes();
  }

  void _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notesData = prefs.getString('notes');
    if (notesData != null) {
      Iterable decoded = jsonDecode(notesData);
      _notes = decoded.map((note) => Note.fromJson(note)).toList();
      notifyListeners();
    }
  }

  void _saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('notes', jsonEncode(_notes));
  }

  void addNewNote(String title, String description, DateTime createdAt) {
    final newNote = Note(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      createdAt: createdAt,
    );

    _notes.add(newNote);
    _saveNotes(); // Save notes after adding new note
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    _saveNotes(); // Save notes after deleting a note
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
      _saveNotes(); // Save notes after updating a note
      notifyListeners();
    }
  }
}
