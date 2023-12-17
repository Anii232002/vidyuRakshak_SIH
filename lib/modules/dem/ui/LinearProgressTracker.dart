import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final String currentStep;
  final List<String> steps = [
    'Start',
    'Inspection',
    'Work in Progress',
    'Finished'
  ];

  CustomLinearProgressIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: steps.map((step) {
            bool isActive = step == currentStep;
            return Column(
              children: [
                Icon(
                  getIconForStep(step),
                  color: isActive
                      ? Colors.blue
                      : Colors.grey, // Change icon color based on active step
                ),
                Text(
                  step,
                  style: TextStyle(
                    color: isActive
                        ? Colors.blue
                        : Colors.grey, // Change text color based on active step
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        LinearProgressIndicator(
          value: getValueForStep(currentStep), //0.120,0.35
          minHeight: 10,
          backgroundColor: Colors.grey[300]!,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ],
    );
  }

  IconData getIconForStep(String step) {
    // Define icons for each step
    switch (step) {
      case 'Start':
        return Icons.play_arrow;
      case 'Inspection':
        return Icons.search;
      case 'Work in Progress':
        return Icons.build;
      case 'Finished':
        return Icons.check_circle;
      default:
        return Icons.error;
    }
  }

  double getValueForStep(String step) {
    // Define icons for each step
    switch (step) {
      case 'Start':
        return 0.120;
      case 'Inspection':
        return 0.350;
      case 'Work in Progress':
        return 0.630;
      case 'Finished':
        return 1.00;
      default:
        return 0.120;
    }
  }
}
