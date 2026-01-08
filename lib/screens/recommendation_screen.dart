import 'package:flutter/material.dart';
import '../services/recommendation_api.dart';

class RecommendationScreen extends StatefulWidget {
  final List<Map<String, dynamic>> symptoms;

  const RecommendationScreen({super.key, required this.symptoms});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  bool isLoading = true;

  List causes = [];
  List tests = [];

  @override
  void initState() {
    super.initState();
    loadRecommendations();
  }

  Future<void> loadRecommendations() async {
    try {
      final data = await RecommendationApi.fetchRecommendations(
        widget.symptoms,
      );

      setState(() {
        causes = data["possibleCauses"] ?? [];
        tests = data["recommendedTests"] ?? [];
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Recommendation error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12001A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Your Symptom Analysis"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.purple))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...buildSymptomWiseSections(),
                  const SizedBox(height: 24),
                  disclaimerCard(),
                ],
              ),
            ),
    );
  }

  /// 🔹 BUILD UI PER SYMPTOM (TESTS FIRST → CAUSES LATER)
  List<Widget> buildSymptomWiseSections() {
    final int symptomCount = widget.symptoms.length;

    final int causesPerSymptom = symptomCount == 0
        ? 0
        : (causes.length / symptomCount).ceil();
    final int testsPerSymptom = symptomCount == 0
        ? 0
        : (tests.length / symptomCount).ceil();

    return List.generate(symptomCount, (index) {
      final symptomName = widget.symptoms[index]["symptomId"];

      final symptomCauses = causes
          .skip(index * causesPerSymptom)
          .take(causesPerSymptom)
          .toList();

      final symptomTests = tests
          .skip(index * testsPerSymptom)
          .take(testsPerSymptom)
          .toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// SYMPTOM HEADING
          Text(
            "🩺 $symptomName",
            style: const TextStyle(
              color: Colors.purpleAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          /// 🧪 TESTS FIRST
          if (symptomTests.isNotEmpty) ...[
            sectionTitle("🧪 Recommended Tests"),
            ...symptomTests.map(
              (t) => infoCard(
                title: t["name"] ?? "Medical Test",
                description: (t["purpose"]?.toString().isNotEmpty ?? false)
                    ? t["purpose"]
                    : "Recommended based on this symptom.",
                icon: Icons.science,
              ),
            ),
          ],

          /// 🚨 CAUSES AFTER
          if (symptomCauses.isNotEmpty) ...[
            const SizedBox(height: 16),
            sectionTitle("🚨 Possible Causes"),
            ...symptomCauses.map(
              (c) => infoCard(
                title: c["name"] ?? "Possible Cause",
                description: (c["description"]?.toString().isNotEmpty ?? false)
                    ? c["description"]
                    : "Consult a doctor for further evaluation.",
                icon: Icons.warning_amber_rounded,
              ),
            ),
          ],

          const SizedBox(height: 28),
        ],
      );
    });
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget infoCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.purple, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget disclaimerCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "⚠️ This is not a medical diagnosis. Please consult a doctor for confirmation.",
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
