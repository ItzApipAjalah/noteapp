import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/models/NotesOperation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp/screen/add_screen.dart';
import 'package:notesapp/screen/edit_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        child: Icon(Icons.add, size: 30, color: Colors.white),
        backgroundColor: const Color.fromRGBO(42, 170, 210, 1),
      ),
      appBar: AppBar(
        title: Text(
          'ME Notes',
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<NotesOperation>(
        builder: (context, NotesOperation data, child) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200]),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: data.getNotes.length,
                itemBuilder: (context, index) {
                  return NotesCard(data.getNotes[index]);
                },
              ))
            ],
          );
        },
      ),
    );
  }
}

class NotesCard extends StatelessWidget {
  final Note note;

  NotesCard(this.note);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditScreen(note),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        height: 150,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(237, 237, 237, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              note.description,
              style: TextStyle(fontSize: 17),
            ),
            Text(
              'Created At: ${note.createdAt.toString()}',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditScreen(note),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Hapus catatan ini?'),
                            content: Text(
                                'Apakah Anda yakin ingin menghapus catatan ini'),
                            actions: <Widget>[
                              TextButton(
                                  child: Text('Tidak'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                              TextButton(
                                  child: Text('Iya'),
                                  onPressed: () {
                                    Provider.of<NotesOperation>(context,
                                            listen: false)
                                        .deleteNote(note.id);
                                    Navigator.of(context).pop();
                                  })
                            ],
                          );
                        });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}