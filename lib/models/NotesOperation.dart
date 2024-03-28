import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart'; // Import path_provider
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

  Future<String> _saveImage(File image) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final savedImage = await image.copy('${appDir.path}/$fileName');
    return savedImage.path;
  }

  void addNewNote(
      String title, String description, DateTime createdAt, File? image) async {
    String imagePath = '';
    if (image != null) {
      imagePath = await _saveImage(image);
    }
    final newNote = Note(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      createdAt: createdAt,
      imagePath: imagePath,
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

  void updateNote(
      String id, String newTitle, String newDescription, File? newImage) async {
    final noteIndex = _notes.indexWhere((note) => note.id == id);
    if (noteIndex != -1) {
      String newImagePath = _notes[noteIndex].imagePath ?? '';
      if (newImage != null) {
        newImagePath = await _saveImage(newImage);
      }
      _notes[noteIndex] = Note(
        id: id,
        title: newTitle,
        description: newDescription,
        createdAt: _notes[noteIndex].createdAt,
        imagePath: newImagePath,
      );
      _saveNotes(); // Save notes after updating a note
      notifyListeners();
    }
  }
}
