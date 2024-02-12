import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notesapp/models/NotesOperation.dart';
import 'package:notesapp/screen/home_screen.dart';
import 'package:supabase/supabase.dart';

void main() {
  final supabaseUrl = 'https://bjrpysehgevgykrjrank.supabase.co';
  final supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJqcnB5c2VoZ2V2Z3lrcmpyYW5rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDc3MTIyNTksImV4cCI6MjAyMzI4ODI1OX0.C7XjJkw9Rcokx5nXyORXK3JDidyyAxx5Aj5DaDXxaBY';
  final client = SupabaseClient(supabaseUrl, supabaseKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotesOperation>(
      create: (context) => NotesOperation(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
