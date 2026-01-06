import 'package:flutter/material.dart';

class HealthyLifestylePage extends StatelessWidget {
  const HealthyLifestylePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F011E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F011E),
        title: const Text("Healthy Lifestyle"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _infoCard(
            "Daily Habits",
            "• Wake up at the same time\n• Drink 2–3L water\n• Avoid screens before bed",
            Icons.wb_sunny,
          ),
          _infoCard(
            "Sleep Hygiene",
            "Aim for 7–9 hours of sleep.\nKeep your room dark & cool.",
            Icons.bedtime,
          ),
          _infoCard(
            "Mindfulness",
            "Practice 5–10 minutes of meditation or deep breathing daily.",
            Icons.self_improvement,
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String content, IconData icon) {
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
          Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 10),
              Text(title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
          const SizedBox(height: 10),
          Text(content, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
