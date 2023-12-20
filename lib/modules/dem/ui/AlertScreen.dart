import 'package:flutter/material.dart';
import 'package:vidyurakshak_web/modules/dem/model/TaskModel.dart';
import 'package:vidyurakshak_web/modules/dem/ui/task_details.dart';

// Define a data structure for tasks

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Alert Zones'),
        ),
        body: AlertZonesScreen(),
      ),
    );
  }
}

class AlertZonesScreen extends StatelessWidget {
  // Sample data for yellow and red tasks
  final List<Task> redTasks = [
    Task(
        lat: 16.026463,
        lon: 73.996124,
        priority: 1,
        placeName: 'Maliwadi',
        isNew: 0),
    Task(
        lat: 16.014255,
        lon: 73.964195,
        priority: 1,
        placeName: 'Shirshinge',
        isNew: 0),
    Task(
        lat: 16.002704,
        lon: 73.951321,
        priority: 1,
        placeName: 'Sangli',
        isNew: 0),
    Task(
        lat: 15.993707,
        lon: 73.946081,
        priority: 1,
        placeName: 'Kalambist',
        isNew: 0),
    // Add more yellow tasks here
  ];

  final List<Task> yellowTasks = [
    Task(
        lat: 15.990702,
        lon: 73.942297,
        priority: 2,
        placeName: 'Kalambist',
        isNew: 0),
    Task(
        lat: 15.990702,
        lon: 73.942297,
        priority: 2,
        placeName: 'Sangli',
        isNew: 0),
    Task(
        lat: 15.995487,
        lon: 73.946245,
        priority: 2,
        placeName: 'Kalambist',
        isNew: 0),
    Task(
        lat: 15.913844,
        lon: 73.900262,
        priority: 2,
        placeName: 'Kolhapur',
        isNew: 0),
    Task(
        lat: 15.924001,
        lon: 73.908693,
        priority: 2,
        placeName: 'Sangli',
        isNew: 0),
    // Add more red tasks here
  ];

  Widget _buildTaskCard(BuildContext context, Task task, Color color) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetails(task: task, color: color),
            ),
          );
        },
        child: Card(
            // Other card details remain the same...
            child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Text(
              task.priority.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          title: Text(task.placeName),
          subtitle: Text('Lat: ${task.lat}, Lon: ${task.lon}'),
          // Replace this Container with your MapView widget
          trailing: Container(
            width: 80,
            height: 80,
            color: Colors.grey, // Replace with your map view
            // Replace with your map view widget implementation
            // child: YourMapViewWidget(task.lat, task.lon),
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.yellow[100],
            child: ListView.builder(
              itemCount: yellowTasks.length,
              itemBuilder: (context, index) {
                return _buildTaskCard(
                  context,
                  yellowTasks[index],
                  Colors.yellow,
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.red[100],
            child: ListView.builder(
              itemCount: redTasks.length,
              itemBuilder: (context, index) {
                return _buildTaskCard(
                  context,
                  redTasks[index],
                  Colors.red,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
