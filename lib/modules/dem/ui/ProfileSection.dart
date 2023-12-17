import 'package:flutter/material.dart';
import 'package:vidyurakshak_web/utils/theme/app_colors.dart';
import 'StatusWidget.dart';

class ProfileSection extends StatelessWidget {
  final String imagePath;
  final String name;

  const ProfileSection({
    Key? key,
    required this.imagePath,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryColor,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 10,
                  width: 30,
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(imagePath),
                    ),
                    SizedBox(height: 10),
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: 40, width: 40), // Adjust spacing between columns
                Column(
                  children: [
                    // Add widgets for the second nested column here

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'Position : Zonal Head',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Region : Sangli',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Taluka : Miraj',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Widgets for alerts, tasks completed, tasks in progress
                  // You can create separate widgets for these or use existing widgets
                  StatusWidget(
                    label: 'Alerts',
                    count: 10,
                    circleColor: Colors.red,
                    icon: Icons.warning,
                    iconColor: Colors.red,
                  ),
                  StatusWidget(
                    label: 'Tasks Completed',
                    count: 25,
                    circleColor: Colors.green,
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                  ),
                  StatusWidget(
                    label: 'Tasks in Progress',
                    count: 15,
                    circleColor: Colors.yellow,
                    icon: Icons.timer,
                    iconColor: Colors.yellow,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
