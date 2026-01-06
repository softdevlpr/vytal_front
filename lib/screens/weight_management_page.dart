import 'package:flutter/material.dart';

class WeightManagementPage extends StatelessWidget {
  const WeightManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F011E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F011E),
        title: const Text("Weight Management"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _card(
            "Balanced Nutrition",
            "• Eat whole foods\n• Reduce sugar & junk\n• Increase protein & fiber",
            Icons.restaurant,
          ),
          _card(
            "Portion Control",
            "Eat slowly and stop when 80% full.\nAvoid late-night snacking.",
            Icons.scale,
          ),
          _card(
            "Consistency",
            "Healthy weight loss = 0.5 kg/week.\nAvoid crash diets.",
            Icons.trending_up,
          ),
        ],
      ),
    );
  }

  Widget _card(String title, String text, IconData icon) {
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
