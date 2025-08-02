import 'package:flutter/material.dart';
import 'fatigue_page.dart';
import 'injury_page.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Predictions"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FatiguePage()),
                );
              },
              child: const Text("Fatigue Prediction"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InjuryPage()),
                );
              },
              child: const Text("Injury Risk Prediction"),
            ),
          ],
        ),
      ),
    );
  }
}
