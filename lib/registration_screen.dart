import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final String language;
  RegistrationScreen({required this.language});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '', lastName = '', dob = '', username = '', password = '';
  bool _obscurePassword = true;

  final RegExp nameRegExp = RegExp(r'^[A-Za-z]+$');
  final RegExp dobRegExp = RegExp(r'^\d{2}-\d{2}-\d{4}$');
  final RegExp usernameRegExp = RegExp(r'^[A-Za-z][A-Za-z0-9]{0,19}$');
  final RegExp passwordRegExp =
  RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,12}$');

  @override
  Widget build(BuildContext context) {
    bool isHindi = widget.language == 'hi';

    return Scaffold(
      appBar: AppBar(title: Text(isHindi ? 'पंजीकरण' : 'Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: isHindi ? 'पहला नाम' : 'First Name'),
                onChanged: (val) => firstName = val,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return isHindi
                        ? 'पहला नाम आवश्यक है'
                        : 'First name is required';
                  } else if (!nameRegExp.hasMatch(val)) {
                    return isHindi
                        ? 'केवल अक्षरों की अनुमति है'
                        : 'Only letters are allowed';
                  } else if (val.length > 20) {
                    return isHindi
                        ? '20 वर्णों से अधिक नहीं हो सकता'
                        : 'Cannot be more than 20 characters';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: isHindi ? 'अंतिम नाम' : 'Last Name'),
                onChanged: (val) => lastName = val,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return isHindi
                        ? 'अंतिम नाम आवश्यक है'
                        : 'Last name is required';
                  } else if (!nameRegExp.hasMatch(val)) {
                    return isHindi
                        ? 'केवल अक्षरों की अनुमति है'
                        : 'Only letters are allowed';
                  } else if (val.length > 20) {
                    return isHindi
                        ? '20 वर्णों से अधिक नहीं हो सकता'
                        : 'Cannot be more than 20 characters';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: isHindi
                        ? 'जन्म तिथि (दिन-महीना-वर्ष)'
                        : 'Date of Birth (DD-MM-YYYY)'),
                onChanged: (val) => dob = val,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return isHindi
                        ? 'जन्म तिथि आवश्यक है'
                        : 'Date of Birth is required';
                  } else if (!dobRegExp.hasMatch(val)) {
                    return isHindi
                        ? 'मान्य प्रारूप दिन-महीना-वर्ष होना चाहिए'
                        : 'Must be in valid format DD-MM-YYYY';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: isHindi ? 'यूज़रनेम बनाएँ' : 'Create Username'),
                onChanged: (val) => username = val,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return isHindi
                        ? 'यूज़रनेम आवश्यक है'
                        : 'Username is required';
                  } else if (!usernameRegExp.hasMatch(val)) {
                    return isHindi
                        ? '1 अक्षर से शुरू होकर 20 वर्णों तक अक्षर/संख्या हो सकते हैं'
                        : 'Must start with a letter, max 20 characters, letters and digits only';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText:
                  isHindi ? 'पासवर्ड बनाएँ' : 'Create Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                onChanged: (val) => password = val,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return isHindi
                        ? 'पासवर्ड आवश्यक है'
                        : 'Password is required';
                  } else if (!passwordRegExp.hasMatch(val)) {
                    return isHindi
                        ? '8-12 वर्ण, पासवर्ड में एक अपर केस (A-Z), एक संख्या और एक विशेष अक्षर होना चाहिए'
                        : 'Must be 8-12 chars with 1 uppercase, 1 number, 1 special char';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await DatabaseHelper()
                        .registerUser(username.trim(), password.trim());

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        title: Text(isHindi
                            ? 'पंजीकरण सफल'
                            : 'Registration Successful'),
                        content: Text(isHindi
                            ? 'आपका पंजीकरण सफल रहा।'
                            : 'Your registration was successful.'),
                        actions: [
                          TextButton(
                            child: Text(isHindi ? 'ठीक है' : 'OK'),
                            onPressed: () {
                              Navigator.of(context).pop(); // close dialog
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomeScreen(
                                    username: firstName,
                                    language: widget.language,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  }
                },
                child: Text(isHindi ? 'पंजीकरण करें' : 'Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
