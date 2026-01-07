import 'package:flutter/material.dart';
import 'intensity_question_page.dart';

class AddSymptomsPage extends StatefulWidget {
  const AddSymptomsPage({super.key});

  @override
  State<AddSymptomsPage> createState() => _AddSymptomsPageState();
}

class _AddSymptomsPageState extends State<AddSymptomsPage> {
  final List<String> allSymptoms = [
    "Fever",
    "Chills / Sweating",
    "Fatigue",
    "Headache",
    "Migraine",
    "Sore Throat",
    "Cough (Wet / Dry)",
    "Sneezing",
    "Shortness of Breath",
    "Chest Pain / Tightness",
    "Chest Congestion",
    "Palpitations",
    "Dizziness / Fainting",
    "Swelling in Legs / Feet",
    "Itchy or Watery Eyes",
    "Red Eyes",
    "Watery Eyes",
    "Blurred Vision",
    "Eye Pain",
    "Swelling (Face / Throat)",
    "Nausea",
    "Abdominal Pain",
    "Bloating",
    "Diarrhea",
    "Constipation",
    "Heartburn",
    "Painful Urination",
    "Frequent Urination",
    "Blood in Urine",
    "Urinary Incontinence",
    "Irregular Periods",
    "Rash / Redness",
    "Muscle Ache",
    "Joint Pain",
    "Back Pain",
    "Confusion / Brain Fog",
    "Sleep Disturbance",
    "Tremors",
    "Numbness / Tingling",
    "Seizures",
  ];

  final List<String> commonSymptoms = [
    "Fever",
    "Cough",
    "Headache",
    "Fatigue",
    "Sore Throat",
    "Shortness of Breath",
    "Muscle Ache",
    "Nausea / Vomiting",
  ];

  final Set<String> selectedSymptoms = {};
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F011E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Skip", style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select your symptoms",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Choose all that apply",
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 20),

            /// DROPDOWN SEARCH
            DropdownButtonFormField<String>(
              value: dropdownValue,
              dropdownColor: const Color(0xFF1E1E2C),
              iconEnabledColor: Colors.white70,
              decoration: InputDecoration(
                hintText: "Search / Select symptom",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF1E1E2C),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
              ),
              style: const TextStyle(color: Colors.white),
              items: allSymptoms
                  .map(
                    (symptom) =>
                        DropdownMenuItem(value: symptom, child: Text(symptom)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null && !selectedSymptoms.contains(value)) {
                  setState(() {
                    selectedSymptoms.add(value);
                    dropdownValue = null;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            /// SELECTED SYMPTOMS LIST
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: selectedSymptoms
                  .map(
                    (symptom) => Chip(
                      label: Text(symptom),
                      backgroundColor: const Color(0xFF9D4EDD),
                      labelStyle: const TextStyle(color: Colors.white),
                      deleteIconColor: Colors.white,
                      onDeleted: () {
                        setState(() {
                          selectedSymptoms.remove(symptom);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 20),

            const Text(
              "Common Symptoms",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 10),

            /// COMMON SYMPTOMS AS CHIPS (AESTHETIC)
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: commonSymptoms.map((symptom) {
                final isSelected = selectedSymptoms.contains(symptom);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected
                          ? selectedSymptoms.remove(symptom)
                          : selectedSymptoms.add(symptom);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF9D4EDD)
                          : const Color(0xFF1E1E2C),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.white38,
                      ),
                    ),
                    child: Text(
                      symptom,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            /// NEXT BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: selectedSymptoms.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => IntensityQuestionPage(
                              symptoms: selectedSymptoms.toList(),
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9D4EDD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("Next", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
