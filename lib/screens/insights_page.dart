import 'package:flutter/material.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Static example data
    final weekSymptoms = {
      "Fever": 3,
      "Fatigue": 5,
      "Headache": 2,
      "Cough": 4,
    };

    final monthSymptoms = {
      "Fatigue": 12,
      "Fever": 8,
      "Headache": 7,
      "Nausea": 3,
    };

    return Scaffold(
      backgroundColor: const Color(0xFF0F011E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F011E),
        elevation: 0,
        title: const Text("Insights"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Symptom Insights",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              /// WEEKLY FREQUENT SYMPTOMS
              _frequencyCard(
                title: "This Week",
                symptoms: weekSymptoms,
                gradientColors: const [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
              ),

              const SizedBox(height: 16),

              /// MONTHLY FREQUENT SYMPTOMS
              _frequencyCard(
                title: "This Month",
                symptoms: monthSymptoms,
                gradientColors: const [Color(0xFF6A00F4), Color(0xFF9D4EDD)],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// FREQUENCY CARD WITH TREND
  Widget _frequencyCard({
    required String title,
    required Map<String, int> symptoms,
    required List<Color> gradientColors,
  }) {
    // Sort top 3 symptoms
    final topSymptoms = symptoms.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top3 = topSymptoms.take(3).toList();

    final maxCount = symptoms.values.isEmpty
        ? 1
        : symptoms.values.reduce((a, b) => a > b ? a : b);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card title
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Most Frequent Symptoms
          const Text(
            "Most Frequent Symptoms:",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 10,
            children: top3.map((entry) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${entry.key} (${entry.value})",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 14),

          // Symptom Trends
          const Text(
            "Symptom Trends:",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Column(
            children: symptoms.entries.map((entry) {
              final widthFactor = entry.value / (maxCount);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        entry.key,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: widthFactor,
                            child: Container(
                              height: 18,
                              decoration: BoxDecoration(
                                color: const Color(0xFF9D4EDD),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${entry.value}",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
