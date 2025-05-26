import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'login_screen.dart'; // Make sure this exists

class LanguageSelectionScreen extends StatelessWidget {
  final String action;

  const LanguageSelectionScreen({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dil ki Suraksha'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/app_icon.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 24),
            Text(
              'भाषा चुनें / Select Language',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => action == 'register'
                        ? RegistrationScreen(language: 'hi')
                        : LoginScreen(language: 'hi'),
                  ),
                );
              },
              child: Text('हिंदी'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => action == 'register'
                        ? RegistrationScreen(language: 'en')
                        : LoginScreen(language: 'en'),
                  ),
                );
              },
              child: Text('English'),
            ),
          ],
        ),
      ),
    );
  }
}
