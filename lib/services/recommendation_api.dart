import 'dart:convert';
import 'package:http/http.dart' as http;

class RecommendationApi {
  static const String _url =
      "https://vytal-backend-dxx8.onrender.com/api/recommend";

  static Future<Map<String, dynamic>> fetchRecommendations(
    List<Map<String, dynamic>> symptoms,
  ) async {
    List allTests = [];
    List allCauses = [];

    for (final s in symptoms) {
      final response = await http.post(
        Uri.parse(_url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": "demo_user",
          "symptom_name": s["symptomId"],
          "intensity": s["intensity"],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        allTests.addAll(data["recommendedTests"] ?? []);
        allCauses.addAll(data["possibleCauses"] ?? []);
      }
    }

    return {"recommendedTests": allTests, "possibleCauses": allCauses};
  }
}
