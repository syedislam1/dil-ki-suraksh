import 'package:flutter/material.dart';
import 'heart_tips.dart';
import 'risk_check.dart';
import 'emergency_help.dart';
import 'reminders.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  final String language;

  HomeScreen({required this.username, required this.language});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Dil Se Suraksha'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen(username: username)),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            Icon(Icons.favorite, size: 100, color: Colors.redAccent),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(20),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildTile(context, language == 'hi' ? 'दिल की सलाह' : 'Heart Tips', Icons.favorite, HeartTipsScreen(language: language)),
                  _buildTile(context, language == 'hi' ? 'जोखिम जांच' : 'Risk Check', Icons.help, RiskCheckScreen(language: language)),
                  _buildTile(context, language == 'hi' ? 'आपातकाल' : 'Emergency', Icons.warning, EmergencyHelpScreen(language: language)),
                  _buildTile(context, language == 'hi' ? 'अनुस्मारक' : 'Reminders', Icons.alarm, ReminderScreen(language: language)),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, String label, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal[100],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.teal[800]),
            SizedBox(height: 10),
            Text(label, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}