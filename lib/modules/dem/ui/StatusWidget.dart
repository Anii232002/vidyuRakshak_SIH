import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final String label;
  final int count;
  final Color circleColor;
  final IconData icon;
  final Color iconColor;

  const StatusWidget({
    Key? key,
    required this.label,
    required this.count,
    required this.circleColor,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: circleColor, width: 2),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: iconColor,
              ),
              Positioned(
                bottom: 0,
                // left: 0,
                // right: 0,
                // top: 0,
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
