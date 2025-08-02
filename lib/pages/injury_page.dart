import 'package:flutter/material.dart';
import '../api/prediction_api.dart';

class InjuryPage extends StatefulWidget {
  const InjuryPage({super.key});

  @override
  State<InjuryPage> createState() => _InjuryPageState();
}

class _InjuryPageState extends State<InjuryPage> {
  double previousInjuries = 0.0;
  double trainingIntensity = 5.0;
  double bmi = 20.0;
  String? injuryRisk;
  bool isLoading = false;

  Future<void> predictInjury() async {
    setState(() {
      isLoading = true;
      injuryRisk = null;
    });

    try {
      final result = await PredictionAPI.predictInjury(
        previousInjuries: previousInjuries,
        trainingIntensity: trainingIntensity,
        bmi: bmi,
      );
      setState(() {
        injuryRisk = result['label'];
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
        title: const Text("Injury Risk Prediction"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Previous Injuries: ${previousInjuries.toStringAsFixed(1)}'),
            Slider(
              value: previousInjuries,
              min: 0,
              max: 10,
              onChanged: (value) => setState(() => previousInjuries = value),
            ),
            const SizedBox(height: 16),

            Text('Training Intensity: ${trainingIntensity.toStringAsFixed(1)}'),
            Slider(
              value: trainingIntensity,
              min: 0,
              max: 10,
              onChanged: (value) => setState(() => trainingIntensity = value),
            ),
            const SizedBox(height: 16),

            Text('BMI: ${bmi.toStringAsFixed(1)}'),
            Slider(
              value: bmi,
              min: 15,
              max: 35,
              onChanged: (value) => setState(() => bmi = value),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: isLoading ? null : predictInjury,
              child: Text(isLoading ? 'Predicting...' : 'Predict Injury Risk'),
            ),
            const SizedBox(height: 32),

            if (injuryRisk != null)
              Center(
                child: Text(
                  'Injury Risk: $injuryRisk',
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
