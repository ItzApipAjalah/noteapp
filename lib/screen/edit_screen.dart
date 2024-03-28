import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
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
  late int _titleCursorPosition;
  late int _descriptionCursorPosition;
  File? _image;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _descriptionController =
        TextEditingController(text: widget.note.description);
    _titleCursorPosition = _titleController.text.length;
    _descriptionCursorPosition = _descriptionController.text.length;

    // Jika imagePath pada note tidak null, maka tampilkan gambar yang terkait
    if (widget.note.imagePath != null) {
      _image = File(widget.note.imagePath!);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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
          IconButton(
            icon: Icon(
              Icons.photo_library,
              color: Colors.black,
            ),
            onPressed: () {
              _getImage(ImageSource.gallery);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.black,
            ),
            onPressed: () {
              _getImage(ImageSource.camera);
            },
          ),
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
                  String newTitle = _titleController.text;
                  String newDescription = _descriptionController.text;

                  if (newTitle.isEmpty || newDescription.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Title and description cannot be empty.'),
                      ),
                    );
                  } else if (newTitle == widget.note.title &&
                      newDescription == widget.note.description &&
                      _image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('No data changes were made.'),
                      ),
                    );
                  } else {
                    Provider.of<NotesOperation>(context, listen: false)
                        .updateNote(
                      widget.note.id,
                      newTitle,
                      newDescription,
                      _image,
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data has been updated.'),
                      ),
                    );
                  }
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
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
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
                setState(() {
                  _titleCursorPosition = _titleController.selection.baseOffset;
                });
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
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (value) {
                  setState(() {
                    _descriptionCursorPosition =
                        _descriptionController.selection.baseOffset;
                  });
                },
              ),
            ),
            _image != null
                ? Image.file(_image!)
                : widget.note.imagePath != null
                    ? Image.file(File(widget.note.imagePath!))
                    : SizedBox(), // Menampilkan gambar yang dipilih atau gambar yang ada sebelumnya
            _image != null || widget.note.imagePath != null
                ? IconButton(
                    icon: Icon(Icons.delete, color: Colors.red,),
                    onPressed: () {
                      setState(() {
                        if (widget.note.imagePath != null) {
                          // Hapus gambar dari penyimpanan lokal
                          File(widget.note.imagePath!).deleteSync();
                          // Perbarui catatan dengan menghapus imagePath
                          Provider.of<NotesOperation>(context, listen: false)
                              .updateNote(
                            widget.note.id,
                            widget.note.title,
                            widget.note.description,
                            null, // Set imagePath menjadi null
                          );
                        }
                        // Hapus gambar dari tampilan
                        _image = null;
                      });
                    },
                  )
                : SizedBox(), // Tombol untuk menghapus gambar
          ],
        ),
      ),
    );
  }
}
