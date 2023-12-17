import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vidyurakshak_web/modules/dem/model/task_detail_model.dart';
import 'package:vidyurakshak_web/modules/dem/repository/tasks_repository.dart';
import 'package:vidyurakshak_web/modules/dem/ui/map/ui/map_view_screen.dart';
import 'package:vidyurakshak_web/utils/theme/app_colors.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({Key? key}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetails> {
  int selectedGroupIndex = 0; // Index of the selected group
  String selectedPriority = ''; // Store the selected priority

  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _descriptionTextEditingController =
      TextEditingController();
  TextEditingController _latitudeTextEditingController =
      TextEditingController();
  TextEditingController _longitudeTextEditingController =
      TextEditingController();

  // List of available groups
  List<Map<String, dynamic>> groups = [
    {'groupNo': 1, 'groupName': 'Arjun Seth', 'id': '123'},
    {'groupNo': 2, 'groupName': 'Akhil Deshmukh', 'id': '456'},
    {'groupNo': 3, 'groupName': 'Siddhesh Singh', 'id': '786'},
    {'groupNo': 4, 'groupName': 'Rahul Tiwari', 'id': '254'},

    // ... other groups
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A) Small image box on the left (20% of screen horizontally)

          SizedBox(width: 10), // Add spacing between elements

          // B) Details section in the middle which should be 50% of screen horizontally
          Expanded(
            flex: 7,
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // a) Title text box
                  Center(
                    child: Text(
                      'Assign Task',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 33, 0, 0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    color: Colors.blueGrey[100],
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      width: 800, // Set the desired width
                      height: 200, // Set the desired height
                      child: MapViewScreen(), // Your placeholder widget
                    ), // Replace Placeholder with your image widget
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: _titleTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 30), // Add spacing between elements

                  // b) Description text box
                  TextField(
                    maxLines: 3,
                    controller: _descriptionTextEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 30),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Latitude'),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 30,
                        width: 180,
                        child: TextField(
                          controller: _latitudeTextEditingController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      const Text('Longitude'),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 30,
                        width: 180,
                        child: TextField(
                          controller: _longitudeTextEditingController,
                          decoration: const InputDecoration(
                            hintMaxLines: 2,
                            contentPadding: EdgeInsets.all(5),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ), // Add spacing between elements

                  // c) Priority Buttons
                  const Text(
                    'Select priority :',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 33, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: [
                      _buildPriorityButton('Low', Colors.green),
                      _buildPriorityButton('Medium', Colors.yellow),
                      _buildPriorityButton('High', Colors.red),
                    ],
                  ),

                  const SizedBox(height: 30),
                  Center(
                      child: ElevatedButton(
                    onPressed: () {
                      TasksRepository().addData(
                        TaskDetailModel(
                            title: _titleTextEditingController.text,
                            description: _descriptionTextEditingController.text,
                            teamAssigned: groups[selectedGroupIndex]
                                ['groupName'],
                            active: true,
                            location: GeoPoint(
                                double.parse(
                                    _latitudeTextEditingController.text),
                                double.parse(
                                    _longitudeTextEditingController.text)),
                            priority: selectedPriority.toLowerCase()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.primaryColor, // Change the color as needed
                      minimumSize: Size(200, 50), // Set width and height
                    ),
                    child: Text(
                      'Assign Task',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),

          SizedBox(width: 20), // Add spacing between elements

          // C) Selection of available groups (30% horizontally)
          Expanded(
            flex: 3,
            child: Container(
                color: Colors.blueGrey[100],
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Choose a Group for the task',
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 33, 0, 0),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: groups
                          .asMap()
                          .entries
                          .map(
                            (entry) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedGroupIndex = entry.key;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: selectedGroupIndex == entry.key
                                      ? Colors.green
                                      : null,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Group ${groups[entry.key]['groupNo']}', // Display group number
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Head : ${groups[entry.key]['groupName']}', // Display group number
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Id : ${groups[entry.key]['id']}', // Replace with the actual ID
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 4),
                                        Checkbox(
                                          value:
                                              selectedGroupIndex == entry.key,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              selectedGroupIndex = entry.key;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  // Helper method to create priority buttons
  Widget _buildPriorityButton(String priority, Color color) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedPriority = priority;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(priority),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TaskDetails(),
  ));
}
