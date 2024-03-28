import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:notesapp/models/NotesOperation.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String titleText = '';
  String descriptionText = '';
  File? _image;

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

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
              getImage(ImageSource.gallery);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.black,
            ),
            onPressed: () {
              getImage(ImageSource.camera);
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
                  if (titleText.isNotEmpty &&
                      descriptionText.isNotEmpty &&
                      _image != null) {
                    Provider.of<NotesOperation>(context, listen: false)
                        .addNewNote(
                            titleText, descriptionText, DateTime.now(), _image);
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data has been saved.'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Title, description, and image cannot be empty.'),
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
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              onChanged: (value) {
                setState(() {
                  titleText = value;
                });
              },
            ),
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
                style: GoogleFonts.inter(fontSize: 18, color: Colors.black),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (value) {
                  setState(() {
                    descriptionText = value;
                  });
                },
              ),
            ),
            _image != null
                ? Image.file(_image!)
                : SizedBox(), // Menampilkan gambar yang dipilih
            _image != null
                ? IconButton(
                    icon: Icon(Icons.delete, color: Colors.red,),
                    onPressed: () {
                      setState(() {
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
