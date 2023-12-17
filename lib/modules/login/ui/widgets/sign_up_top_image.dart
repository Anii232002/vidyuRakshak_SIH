import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignUpScreenTopImage extends StatelessWidget {
  final double defaultPadding = 16.0;
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sign Up".toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Lottie.asset('assets/login.json'),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}
