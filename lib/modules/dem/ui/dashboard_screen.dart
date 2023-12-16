import 'package:flutter/material.dart';
import 'AnalyticsSection.dart';
import 'ProfileSection.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileSection(
              imagePath: 'assets/profile_icon.png',
              name: 'Krishna Rao',
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Analytics',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 10),
            AnalyticsSection(
              imagesPaths: [
                'assets/croplands.jpg',
                'assets/deciduous_forest.jpg',
                'assets/grasslands.jpg',
                'assets/savannas.jpg',
                // Add image paths for analytics
              ],
              texts: [
                'Crop lands',
                'Forests',
                'Grasslands',
                'Savannas'
                // Add texts for analytics
              ],
            ),
            // Other widgets or sections can be added here if needed
          ],
        ),
      ),
    );
  }
}
