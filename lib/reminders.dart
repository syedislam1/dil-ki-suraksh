import 'package:flutter/material.dart';

class ReminderScreen extends StatelessWidget {
  final String language;
  ReminderScreen({required this.language});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reminders')),
      body: Center(child: Text('Coming Soon...')),
    );
  }
}