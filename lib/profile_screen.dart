import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  ProfileScreen({required this.username});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _dobController;
  late TextEditingController _emergencyContactController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.username);
    _lastNameController = TextEditingController();
    _dobController = TextEditingController();
    _emergencyContactController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    // You can later replace this with actual persistent storage (e.g., SQLite, Firebase, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile updated successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Edit your details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),

            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 10),

            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 10),

            TextField(
              controller: _dobController,
              decoration: InputDecoration(labelText: 'Date of Birth (DD-MM-YYYY)'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 10),

            TextField(
              controller: _emergencyContactController,
              decoration: InputDecoration(labelText: 'Emergency Contact Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _saveProfile,
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
