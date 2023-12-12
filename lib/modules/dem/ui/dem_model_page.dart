import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class DemModelPage extends StatefulWidget {
  const DemModelPage({super.key});

  @override
  State<DemModelPage> createState() => _DemModelPageState();
}

class _DemModelPageState extends State<DemModelPage> {
  // Flutter3DController _controller = Flutter3DController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: ModelViewer(
        src: 'assets/power_line_dem.glb',
        backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
        alt: 'A 3D model of an astronaut',
        ar: true,
        autoRotate: true,
      )),
    );
  }
}
