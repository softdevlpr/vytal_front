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
          : (causes.isEmpty && tests.isEmpty)
          ? const Center(
              child: Text(
                "No recommendations available for the selected symptoms.",
                style: TextStyle(color: Colors.white70),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("🚨 Possible Causes"),
                  ...causes.map(
                    (c) => infoCard(
                      title: c["name"] ?? "Possible Cause",
                      description:
                          (c["description"]?.toString().isNotEmpty ?? false)
                          ? c["description"]
                          : "Consult a doctor for detailed evaluation.",
                      icon: Icons.warning_amber_rounded,
                    ),
                  ),

                  const SizedBox(height: 24),

                  sectionTitle("🧪 Recommended Tests"),
                  ...tests.map(
                    (t) => infoCard(
                      title: t["name"] ?? "Medical Test",
                      description:
                          (t["purpose"]?.toString().isNotEmpty ?? false)
                          ? t["purpose"]
                          : "Recommended based on your symptoms.",
                      icon: Icons.science,
                    ),
                  ),

                  const SizedBox(height: 24),

                  disclaimerCard(),
                ],
              ),
            ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
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
          Icon(icon, color: Colors.purple, size: 28),
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
