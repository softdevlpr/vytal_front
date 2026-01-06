import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController =
      TextEditingController(text: "John Doe"); // previous name
  final TextEditingController emailController =
      TextEditingController(text: "johndoe@example.com"); // previous email
  final TextEditingController heightController =
      TextEditingController(text: "170"); // previous height
  final TextEditingController weightController =
      TextEditingController(text: "65"); // previous weight
  final TextEditingController dobController =
      TextEditingController(text: "01/01/2000"); // previous DOB

  String? selectedGender = "Male"; // previous gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F011E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F011E),
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _inputField(
              controller: nameController,
              hint: "Full Name",
              icon: Icons.person_outline,
              keyboardType: TextInputType.name,
            ),

            const SizedBox(height: 16),

            _inputField(
              controller: emailController,
              hint: "Email",
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 16),

            _inputField(
              controller: heightController,
              hint: "Height (cm)",
              icon: Icons.height,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            _inputField(
              controller: weightController,
              hint: "Weight (kg)",
              icon: Icons.monitor_weight_outlined,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            /// DOB PICKER
            TextField(
              controller: dobController,
              readOnly: true,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration(
                hint: "Date of Birth",
                icon: Icons.cake_outlined,
              ),
              onTap: _pickDate,
            ),

            const SizedBox(height: 16),

            /// GENDER
            DropdownButtonFormField<String>(
              value: selectedGender,
              dropdownColor: const Color(0xFF1E1E2C),
              iconEnabledColor: Colors.white70,
              decoration: _inputDecoration(
                hint: "Gender",
                icon: Icons.people_outline,
              ),
              style: const TextStyle(color: Colors.white),
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (value) {
                setState(() => selectedGender = value);
              },
            ),

            const SizedBox(height: 32),

            /// SAVE BUTTON
            Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF7F00FF),
                    Color(0xFFE100FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// DATE PICKER
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(dobController.text.split("/").reversed.join("-")) ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        dobController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _saveProfile() {
    // Here you can also save to database / API
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile updated successfully"),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  /// INPUT FIELD
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required TextInputType keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(hint: hint, icon: icon),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white54),
      filled: true,
      fillColor: const Color(0xFF1E1E2C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}
