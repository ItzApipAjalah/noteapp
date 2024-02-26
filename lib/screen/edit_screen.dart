import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notesapp/models/NotesOperation.dart';
import 'package:notesapp/models/note.dart';

class EditScreen extends StatefulWidget {
  final Note note;

  EditScreen(this.note);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _descriptionController =
        TextEditingController(text: widget.note.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: () {
                  Provider.of<NotesOperation>(context, listen: false)
                      .updateNote(widget.note.id, _titleController.text,
                          _descriptionController.text);
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: 80,
        ),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              controller: _titleController,
              onChanged: (value) {
                _titleController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _titleController.text.length));
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Description',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                controller: _descriptionController,
                onChanged: (value) {
                  _descriptionController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _descriptionController.text.length));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
