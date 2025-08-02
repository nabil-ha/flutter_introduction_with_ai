import 'package:flutter/material.dart';
import '../api/prediction_api.dart';

class FatiguePage extends StatefulWidget {
  const FatiguePage({super.key});

  @override
  State<FatiguePage> createState() => _FatiguePageState();
}

class _FatiguePageState extends State<FatiguePage> {
  double speed = 5.0;
  double strength = 5.0;
  double stamina = 5.0;
  double? fatiguePercentage;
  bool isLoading = false;

  Future<void> predictFatigue() async {
    setState(() {
      isLoading = true;
      fatiguePercentage = null;
    });

    try {
      final result = await PredictionAPI.predictFatigue(
        speed: speed,
        strength: strength,
        stamina: stamina,
      );
      setState(() {
        fatiguePercentage = result['fatigue_percent'];
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fatigue Prediction"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Speed: ${speed.toStringAsFixed(1)}'),
            Slider(
              value: speed,
              min: 0,
              max: 10,
              onChanged: (value) => setState(() => speed = value),
            ),
            const SizedBox(height: 16),

            Text('Strength: ${strength.toStringAsFixed(1)}'),
            Slider(
              value: strength,
              min: 0,
              max: 10,
              onChanged: (value) => setState(() => strength = value),
            ),
            const SizedBox(height: 16),

            Text('Stamina: ${stamina.toStringAsFixed(1)}'),
            Slider(
              value: stamina,
              min: 0,
              max: 10,
              onChanged: (value) => setState(() => stamina = value),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: isLoading ? null : predictFatigue,
              child: Text(isLoading ? 'Predicting...' : 'Predict Fatigue'),
            ),
            const SizedBox(height: 32),

            if (fatiguePercentage != null)
              Center(
                child: Text(
                  'Fatigue Level: ${fatiguePercentage!.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
