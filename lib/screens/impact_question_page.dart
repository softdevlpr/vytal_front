import 'package:flutter/material.dart';

class ImpactQuestionPage extends StatefulWidget {
  final List<String> symptoms;

  const ImpactQuestionPage({
    super.key,
    required this.symptoms,
  });

  @override
  State<ImpactQuestionPage> createState() => _ImpactQuestionPageState();
}

class _ImpactQuestionPageState extends State<ImpactQuestionPage> {
  final Map<String, int> intensityMap = {};

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
                        Text(
                          symptom,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Slider(
                          value: intensityMap[symptom]!.toDouble(),
                          min: 1,
                          max: 5,
                          divisions: 4,
                          activeColor: const Color(0xFF9D4EDD),
                          inactiveColor: Colors.white24,
                          label: intensityMap[symptom].toString(),
                          onChanged: (value) {
                            setState(() {
                              intensityMap[symptom] = value.toInt();
                            });
                          },
                        ),

                        Text(
                          "Intensity: ${intensityMap[symptom]} / 5",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            /// SUBMIT
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // You now have:
                  // symptom -> intensity mapping
                  print(intensityMap);

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9D4EDD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
