import 'package:flutter/material.dart';

class EmergencyHelpScreen extends StatelessWidget {
  final String language;

  EmergencyHelpScreen({required this.language});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergency Help')),
      body: Center(child: Text('Coming Soon...')),
    );
  }
}