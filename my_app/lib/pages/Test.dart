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
  // Controllers for editable fields
  final TextEditingController nameController = TextEditingController(text: "Matulungins");
  final TextEditingController emailController = TextEditingController(text: "Matulungins@gmail.com");
  final TextEditingController companyController = TextEditingController(text: "January 1,2000");
  final TextEditingController websiteController = TextEditingController(text: "25");
  final TextEditingController mrrController = TextEditingController(text: "Milflores City");



  void _saveProfile() {
    // Show a SnackBar on save
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile information saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
        style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.yellow[800],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Profile icon
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.yellow[800],
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                buildTextField("Name", nameController),
                buildTextField("Email", emailController),
                buildTextField("Birthday", companyController),
                buildTextField("Age", websiteController),
                buildTextField("Address", mrrController),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[800],
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("Save",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable TextField builder
  Widget buildTextField(String label, TextEditingController controller) {
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

  static const labelStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );
}
