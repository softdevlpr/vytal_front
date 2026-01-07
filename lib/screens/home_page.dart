import 'package:flutter/material.dart';

// Pages
import 'add_symptoms_page.dart';
import 'insights_page.dart';
import 'plan_page.dart';
import 'reminder_page.dart';

class HomePage extends StatelessWidget {
  final String userName;
  final String affirmation;
  final bool isLoading;

  const HomePage({
    super.key,
    required this.userName,
    required this.affirmation,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F011E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileHeader(),

              const SizedBox(height: 28),

              _dailyAffirmation(),

              const SizedBox(height: 32),

              _sectionTitle("Your Actions"),

              const SizedBox(height: 16),

              _card(
                context,
                "Track Symptoms",
                "Log how you feel today",
                Icons.favorite_outline,
                const AddSymptomsPage(),
              ),

              const SizedBox(height: 14),

              _card(
                context,
                "Insights",
                "Understand your patterns",
                Icons.bar_chart,
                const InsightsPage(),
              ),

              const SizedBox(height: 14),

              _card(
                context,
                "Lifestyle Tips",
                "Healthy habits for everyday life",
                Icons.check_circle_outline,
                const PlanPage(),
              ),

              const SizedBox(height: 14),

              _card(
                context,
                "Reminders",
                "Never forget your care",
                Icons.notifications_none,
                const ReminderPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- UI PARTS ----------------

  Widget _profileHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 28,
          backgroundColor: Color(0xFF9D4EDD),
          child: Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello $userName 👋",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const Text(
              "How are you feeling today?",
              style: TextStyle(color: Colors.white60),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dailyAffirmation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Affirmation 🌱",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 14),
                Text(
                  affirmation,
                  style: const TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _card(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget page,
  ) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2C),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(subtitle, style: const TextStyle(color: Colors.white60)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
