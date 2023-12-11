import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PrimaryText extends StatelessWidget {
  final FontWeight weight;
  final double size;
  final Color color;
  final String text;

  const PrimaryText({
    Key? key,
    required this.weight,
    required this.size,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: weight, fontSize: size, color: color),
    );
  }
}
