import 'package:flutter/material.dart';

// Pages
import 'add_symptoms_page.dart';
import 'insights_page.dart';
import 'plan_page.dart';
import 'profile_settings_page.dart';
import 'reminder_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              /// PROFILE HEADER
              _profileHeader(context),

              const SizedBox(height: 28),

              /// DAILY AFFIRMATION
              _dailyAffirmation(),

              const SizedBox(height: 32),

              /// SECTION TITLE
              _sectionTitle("Your Actions"),

              const SizedBox(height: 16),

              _navigationCard(
                context,
                title: "Track Symptoms",
                subtitle: "Log how you feel today",
                icon: Icons.favorite_outline,
                isActive: true,
                page: const AddSymptomsPage(),
              ),

              const SizedBox(height: 14),

              _navigationCard(
                context,
                title: "Insights",
                subtitle: "Understand your patterns",
                icon: Icons.bar_chart_rounded,
                isActive: false,
                page: const InsightsPage(),
              ),

              const SizedBox(height: 14),

              _navigationCard(
                context,
                title: "Lifestyle Tips",
                subtitle: "Healthy habits for everyday life",
                icon: Icons.check_circle_outline,
                isActive: false,
                page: const PlanPage(),
              ),

              const SizedBox(height: 14),

              _navigationCard(
                context,
                title: "Reminders",
                subtitle: "Never forget your care",
                icon: Icons.notifications_none,
                isActive: false,
                page: const ReminderPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// PROFILE HEADER
  Widget _profileHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Color(0xFF9D4EDD),
              child: Icon(Icons.person, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Hello User 👋",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "How are you feeling today?",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white70),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfileSettingsPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  /// SECTION TITLE
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
      ),
    );
  }

  /// DAILY AFFIRMATION (BUILT-IN BEAUTIFUL FONT)
  Widget _dailyAffirmation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF7F00FF),
            Color(0xFFE100FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent.withOpacity(0.3),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Today's Affirmation 🌱",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 14),
          Text(
            "I choose to listen to my body and care for it with kindness today.",
            style: TextStyle(
              fontFamily: 'Georgia',
              color: Colors.white,
              fontSize: 24,
              height: 1.45,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  /// NAVIGATION CARD
  Widget _navigationCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isActive,
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
          color:
              isActive ? const Color(0xFF6A00F4) : const Color(0xFF1E1E2C),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}
