import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Test(),
    debugShowCheckedModeBanner: false,
  ));
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final _controllers = {
    "Name": TextEditingController(text: "Matulungins"),
    "Email": TextEditingController(text: "Matulungins@gmail.com"),
    "Birthday": TextEditingController(text: "January 1, 2000"),
    "Age": TextEditingController(text: "25"),
    "Address": TextEditingController(text: "Milflores City"),
  };

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _saveProfile() => _showSnackBar('Profile information saved!');

  void _logout() {
    _showSnackBar('Logged out!');
    // Navigate to initial route or login page
    Navigator.pop(context);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.yellow[800],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildProfileIcon(),
                    const SizedBox(height: 20),
                    ..._controllers.entries
                        .map((entry) => _buildTextField(entry.key, entry.value)),
                    const SizedBox(height: 20),
                    _buildActionButton(
                        "Save", Colors.yellow[800]!, Colors.black, _saveProfile),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildActionButton(
                "Logout", Colors.red[600]!, Colors.white, _logout),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileIcon() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.yellow[800],
      child: const Icon(Icons.person, size: 50, color: Colors.black),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildActionButton(
      String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }
}