import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vidyurakshak_web/modules/dem/model/task_detail_model.dart';
import 'package:vidyurakshak_web/modules/dem/repository/tasks_repository.dart';
import 'package:vidyurakshak_web/utils/enums/priority_enum.dart';
import 'package:vidyurakshak_web/utils/screen_utils/screen_sizes.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final taskStream = TasksRepository().getTaskData();

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
            StreamBuilder<QuerySnapshot>(
                stream: taskStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Wrap(
                      direction: Axis.horizontal,
                      runSpacing: ScreenSizes.screenHeight! * 0.1,
                      spacing: ScreenSizes.screenWidth! * 0.04,
                      children: snapshot.data!.docs
                          .map((DocumentSnapshot documentSnapshot) {
                            Map<String, dynamic> data = documentSnapshot.data()!
                                as Map<String, dynamic>;

                            return TaskWidget(
                              taskDetailModel: TaskDetailModel(
                                  title: data['title'],
                                  active: data['active'],
                                  description: data['description'],
                                  teamAssigned: data['teamAssigned'],
                                  location: data['location'],
                                  priority: data['priority']),
                            );
                          })
                          .toList()
                          .cast());
                })
          ],
        ),
      ),
    ));
  }
}

class TaskWidget extends StatelessWidget {
  final TaskDetailModel taskDetailModel;

  const TaskWidget({super.key, required this.taskDetailModel});

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

  @override
  Widget build(BuildContext context) {
    final double latitude = taskDetailModel.location.latitude;
    final double longitude = taskDetailModel.location.longitude;
    return Container(
      width: ScreenSizes.screenWidth! * 0.2,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: ScreenSizes.screenWidth! * 0.03,
              color: getColor(
                  TaskDetailModel.getPriority(taskDetailModel.priority)),
            ),
            SizedBox(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    latitude,
                    longitude,
                  ),
                  zoom: 14.4746,
                ),
                markers: <Marker>[
                  Marker(
                    markerId: MarkerId('marker1'),
                    position: LatLng(latitude, longitude),
                    infoWindow: InfoWindow(
                        title: 'Priority: ${taskDetailModel.priority}'),
                  ),
                ].toSet(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskDetailModel.title,
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    taskDetailModel.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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
