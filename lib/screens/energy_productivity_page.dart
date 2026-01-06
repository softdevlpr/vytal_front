import 'package:flutter/material.dart';

class EnergyProductivityPage extends StatelessWidget {
  const EnergyProductivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F011E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F011E),
        title: const Text("Energy & Productivity"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _energyCard(
            "Morning Routine",
            "• Wake up early\n• Light stretching\n• Protein-rich breakfast",
            Icons.wb_sunny,
          ),
          _energyCard(
            "Focus Techniques",
            "Use Pomodoro: 25 min work + 5 min break",
            Icons.timer,
          ),
          _energyCard(
            "Avoid Energy Drains",
            "• Reduce caffeine after 4 PM\n• Limit social media",
            Icons.battery_alert,
          ),
        ],
      ),
    );
  }

  Widget _energyCard(String title, String text, IconData icon) {
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
