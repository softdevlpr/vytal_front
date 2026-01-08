import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileApi {
  static Future<void> updateProfile(Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse("https://vytal-backend-dxx8.onrender.com/api/profile/update"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception("Profile update failed");
    }
  }
}
