import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'network/http_override.dart';

// Screens
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/plan_page.dart';
import 'screens/insights_page.dart';
import 'screens/add_symptoms_page.dart';
import 'screens/profile_settings_page.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

/// ---------------- MAIN APP ----------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoginPage(),
    );
  }
}

/// ---------------- BOTTOM NAV ----------------
class BottomNavController extends StatefulWidget {
  final String userName;
  final String email;

  const BottomNavController({
    super.key,
    required this.userName,
    required this.email,
  });

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  int _currentIndex = 0;

  String affirmation = "";
  bool isLoadingAffirmation = true;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _fetchAffirmationOnce();
  }

  Future<void> _fetchAffirmationOnce() async {
    try {
      final res = await http.get(
        Uri.parse(
          "https://vytal-backend-dxx8.onrender.com/api/affirmations/random",
        ),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        affirmation = data["affirmation"];
      }
    } catch (_) {}

    setState(() {
      isLoadingAffirmation = false;

      _pages = [
        HomePage(
          userName: widget.userName,
          affirmation: affirmation,
          isLoading: isLoadingAffirmation,
        ),
        const PlanPage(),
        const InsightsPage(),
        ProfileSettingsPage(userName: widget.userName, email: widget.email),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingAffirmation) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0F011E),
        selectedItemColor: const Color(0xFF9D4EDD),
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex >= 2 ? _currentIndex + 1 : _currentIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddSymptomsPage()),
            );
          } else {
            setState(() {
              _currentIndex = index > 2 ? index - 1 : index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: "Lifestyle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 28),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Insights",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
