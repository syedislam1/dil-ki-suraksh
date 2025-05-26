import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // <- import this instead of language_selection.dart

void main() {
  runApp(DilSeSurakshaApp());
}

class DilSeSurakshaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dil Ki Suraksha',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto', // optional, customize as needed
      ),
      home: WelcomeScreen(), // <- this is the updated starting screen
      debugShowCheckedModeBanner: false,
    );
  }
}
