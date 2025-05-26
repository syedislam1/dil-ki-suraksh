import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _selectedLanguage = 'en'; // Default language

  @override
  Widget build(BuildContext context) {
    bool isHindi = _selectedLanguage == 'hi';

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
              isHindi ? 'स्वागत है' : 'Welcome',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Language Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isHindi ? 'भाषा:' : 'Language:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 12),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  items: [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'hi', child: Text('हिंदी')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegistrationScreen(language: _selectedLanguage),
                  ),
                );
              },
              child: Text(isHindi ? 'पंजीकरण' : 'Register'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoginScreen(language: _selectedLanguage),
                  ),
                );
              },
              child: Text(isHindi ? 'लॉगिन' : 'Login'),
            ),
          ],
        ),
      ),
    );
  }
}
