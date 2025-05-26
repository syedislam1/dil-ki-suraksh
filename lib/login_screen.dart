import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'database_helper.dart'; // Ensure path is correct

class LoginScreen extends StatefulWidget {
  final String language;

  const LoginScreen({Key? key, required this.language}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool _obscurePassword = true;

  Future<void> _attemptLogin() async {
    if (_formKey.currentState!.validate()) {
      final dbHelper = DatabaseHelper();

      bool isValid = await dbHelper.checkUser(username, password);

      if (isValid) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(username: username, language: widget.language),
          ),
        );
      } else {
        bool exists = await dbHelper.userExists(username);
        _showLoginFailedDialog(userExists: exists);
      }
    }
  }

  void _showLoginFailedDialog({required bool userExists}) {
    bool isHindi = widget.language == 'hi';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isHindi ? 'लॉगिन विफल' : 'Login Failed'),
        content: Text(userExists
            ? (isHindi ? 'पासवर्ड गलत है।' : 'Incorrect password.')
            : (isHindi ? 'यूज़रनेम मौजूद नहीं है।' : 'Username does not exist.')),
        actions: [
          if (!userExists)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/register');
              },
              child: Text(isHindi ? 'रजिस्टर करें' : 'Register'),
            ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/forgot_password');
            },
            child: Text(isHindi ? 'पासवर्ड भूल गए?' : 'Forgot Password?'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isHindi ? 'ठीक है' : 'OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isHindi = widget.language == 'hi';

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? 'लॉगिन' : 'Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: isHindi ? 'यूज़रनेम' : 'Username',
                ),
                onChanged: (val) => username = val.trim(),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return isHindi ? 'यूज़रनेम आवश्यक है' : 'Username is required';
                  } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(val)) {
                    return isHindi
                        ? 'यूज़रनेम में केवल अक्षर होने चाहिए'
                        : 'Username must contain only letters';
                  }
                  return null;
                },
              ),
              TextFormField(
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: isHindi ? 'पासवर्ड' : 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                onChanged: (val) => password = val.trim(),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return isHindi ? 'पासवर्ड आवश्यक है' : 'Password is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _attemptLogin,
                child: Text(isHindi ? 'लॉगिन करें' : 'Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
