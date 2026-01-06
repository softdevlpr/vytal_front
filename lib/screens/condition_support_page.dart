import 'package:flutter/material.dart';

class ConditionSupportPage extends StatelessWidget {
  const ConditionSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F011E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F011E),
        title: const Text("Condition Support"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _supportCard(
            "Diabetes Care",
            "• Monitor blood sugar\n• Avoid refined carbs\n• Regular walking",
            Icons.bloodtype,
          ),
          _supportCard(
            "PCOS / Hormonal Health",
            "• Balanced meals\n• Strength training\n• Stress management",
            Icons.female,
          ),
          _supportCard(
            "Mental Wellbeing",
            "• Journaling\n• Therapy if needed\n• Daily gratitude",
            Icons.psychology,
          ),
        ],
      ),
    );
  }

  Widget _supportCard(String title, String text, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A00F4), Color(0xFF9D4EDD)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 10),
          Text(text, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
