import 'dart:convert';
import 'package:http/http.dart' as http;

class api_service {
  static Future<Map<String, dynamic>> fetch_prayer_times(String city,
      String country) async {
    final response = await http.get(Uri.parse(
        "https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=2"));
    if (response.statusCode == 200) {
      return json.decode(response.body)["data"]["timings"];
    } else {
      throw Exception("فشل في جلب مواقيت الصلاة");
    }
  }
}