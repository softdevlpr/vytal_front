import 'package:flutter/material.dart';

class FitnessStrengthPage extends StatelessWidget {
  const FitnessStrengthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F011E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F011E),
        title: const Text("Fitness & Strength"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(
            "Beginner Routine",
            "• 10 squats\n• 10 push-ups\n• 30s plank\nRepeat 2 rounds",
            Icons.fitness_center,
          ),
          _section(
            "Cardio",
            "30 minutes/day:\nWalking, cycling, dancing or swimming",
            Icons.directions_run,
          ),
          _section(
            "Recovery",
            "Stretch after workouts.\nTake at least 1 rest day/week.",
            Icons.healing,
          ),
        ],
      ),
    );
  }

  Widget _section(String title, String text, IconData icon) {
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
