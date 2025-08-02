import 'dart:convert';
import 'package:http/http.dart' as http;

class PredictionAPI {
  static const String baseUrl = 'https://fatigue-injury.onrender.com';

  /// Predicts injury risk
  static Future<Map<String, dynamic>> predictInjury({
    required double previousInjuries,
    required double trainingIntensity,
    required double bmi,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/predict-injury'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Previous_Injuries': previousInjuries,
          'Training_Intensity': trainingIntensity,
          'BMI': bmi,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to predict injury: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error predicting injury: $e');
    }
  }

  /// Predicts fatigue percentage
  static Future<Map<String, dynamic>> predictFatigue({
    required double speed,
    required double strength,
    required double stamina,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/predict-fatigue'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Speed': speed,
          'Strength': strength,
          'Stamina': stamina,
        }),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to predict fatigue: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error predicting fatigue: $e');
    }
  }
}
