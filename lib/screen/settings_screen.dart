import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<settings> {
  bool _darkThemeEnabled = false; // Default to light theme

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: ListView(
        children: [
          ListTile(
            title: Text('Dark Theme'),
            trailing: Switch(
              value: _darkThemeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkThemeEnabled = value;
                  // Here you can implement your logic to switch themes
                  // For simplicity, I'm just printing the theme status
                  print('Dark Theme Enabled: $_darkThemeEnabled');
                });
              },
            ),
          ),
          // Add more settings here if needed
        ],
      ),
    );
  }
}
