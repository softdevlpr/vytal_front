import 'package:flutter/material.dart';

// Import pages (create these pages if not yet created)
import 'healthy_lifestyle_page.dart';
import 'weight_management_page.dart';
import 'fitness_strength_page.dart';
import 'condition_support_page.dart';
import 'energy_productivity_page.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F011E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F011E),
        elevation: 0,
        title: const Text("Your Daily Plan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            _buildPlanItem(
              context,
              title: "Healthy Lifestyle",
              subtitle: "Balanced habits for everyday wellness",
              icon: Icons.favorite,
              page: const HealthyLifestylePage(),
            ),

            const SizedBox(height: 16),

            _buildPlanItem(
              context,
              title: "Weight Management",
              subtitle: "Smart nutrition & weight goals",
              icon: Icons.monitor_weight,
              page: const WeightManagementPage(),
            ),

            const SizedBox(height: 16),

            _buildPlanItem(
              context,
              title: "Fitness & Strength",
              subtitle: "Build strength & stay active",
              icon: Icons.fitness_center,
              page: const FitnessStrengthPage(),
            ),

            const SizedBox(height: 16),

            _buildPlanItem(
              context,
              title: "Condition Support",
              subtitle: "Support for specific health conditions",
              icon: Icons.health_and_safety,
              page: const ConditionSupportPage(),
            ),

            const SizedBox(height: 16),

            _buildPlanItem(
              context,
              title: "Energy & Productivity",
              subtitle: "Boost focus, energy & daily output",
              icon: Icons.bolt,
              page: const EnergyProductivityPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6A00F4), Color(0xFF9D4EDD)],
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
