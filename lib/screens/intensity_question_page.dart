import 'package:flutter/material.dart';
import 'recommendation_screen.dart';

class IntensityQuestionPage extends StatefulWidget {
  final List<String> symptoms;

  const IntensityQuestionPage({super.key, required this.symptoms});

  @override
  State<IntensityQuestionPage> createState() => _IntensityQuestionPageState();
}

class _IntensityQuestionPageState extends State<IntensityQuestionPage> {
  final Map<String, int> intensityMap = {};

  final Map<int, String> intensityMeaning = {
    1: "Very Low",
    2: "Low",
    3: "Moderate",
    4: "High",
    5: "Very High",
  };

  @override
  void initState() {
    super.initState();
    for (var symptom in widget.symptoms) {
      intensityMap[symptom] = 3; // default intensity
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F011E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Symptom Intensity",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: widget.symptoms.map((symptom) {
                  final selectedIntensity = intensityMap[symptom]!;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E2C),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Symptom Title
                        Text(
                          symptom,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// Slider
                        Slider(
                          value: selectedIntensity.toDouble(),
                          min: 1,
                          max: 5,
                          divisions: 4,
                          activeColor: const Color(0xFF9D4EDD),
                          inactiveColor: Colors.white24,
                          onChanged: (value) {
                            setState(() {
                              intensityMap[symptom] = value.toInt();
                            });
                          },
                        ),

                        /// Intensity Text
                        Text(
                          "Intensity: $selectedIntensity / 5 — ${intensityMeaning[selectedIntensity]}",
                          style: const TextStyle(color: Colors.white70),
                        ),

                        const SizedBox(height: 12),

                        /// Intensity Meaning Guide
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: intensityMeaning.entries.map((entry) {
                            final isSelected = entry.key == selectedIntensity;

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF9D4EDD)
                                    : Colors.white12,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "${entry.key} • ${entry.value}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white70,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            /// CONTINUE BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  final List<Map<String, dynamic>> symptomsWithIntensity =
                      intensityMap.entries.map((entry) {
                        return {
                          "symptomId": entry.key,
                          "intensity": entry.value,
                        };
                      }).toList();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          RecommendationScreen(symptoms: symptomsWithIntensity),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9D4EDD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("Continue", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
