import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vidyurakshak_web/utils/enums/priority_enum.dart';
import 'package:vidyurakshak_web/utils/screen_utils/screen_sizes.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final taskList = [
    TaskWidget(
      priorityEnum: PriorityEnum.low,
    ),
    TaskWidget(
      priorityEnum: PriorityEnum.medium,
    ),
    TaskWidget(
      priorityEnum: PriorityEnum.low,
    ),
    TaskWidget(
      priorityEnum: PriorityEnum.high,
    ),
    TaskWidget(
      priorityEnum: PriorityEnum.high,
    ),
    TaskWidget(
      priorityEnum: PriorityEnum.medium,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task List',
              style:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              direction: Axis.horizontal,
              runSpacing: ScreenSizes.screenHeight! * 0.1,
              spacing: ScreenSizes.screenWidth! * 0.04,
              children: List.generate(taskList.length, (index) {
                return taskList[index];
              }),
            )
          ],
        ),
      ),
    ));
  }
}

class TaskWidget extends StatelessWidget {
  final PriorityEnum priorityEnum;

  const TaskWidget({super.key, required this.priorityEnum});

  Color getColor(PriorityEnum priorityEnum) {
    switch (priorityEnum) {
      case PriorityEnum.low:
        return Colors.green;
      case PriorityEnum.medium:
        return Colors.yellow;
      case PriorityEnum.high:
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(17.1707, 74.6869),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSizes.screenHeight! * 0.45,
      width: ScreenSizes.screenWidth! * 0.2,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: ScreenSizes.screenWidth! * 0.03,
              color: getColor(priorityEnum),
            ),
            const SizedBox(
              height: 200,
              child: GoogleMap(initialCameraPosition: _kGooglePlex),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sangli region, Maharashtra',
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '500 m crossed',
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
