import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidyurakshak_web/modules/dem/model/task_detail_model.dart';
import 'package:vidyurakshak_web/modules/dem/ui/map/ui/map_view_screen.dart';
import 'package:vidyurakshak_web/utils/enums/priority_enum.dart';
import 'LinearProgressTracker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TaskProgress extends StatefulWidget {
  final TaskDetailModel tdm;
  const TaskProgress({Key? key, required this.tdm}) : super(key: key);

  @override
  State<TaskProgress> createState() => _TaskProgress();
}

class _TaskProgress extends State<TaskProgress> {
  // Flutter3DController _controller = Flutter3DController();

  @override
  Widget build(BuildContext context) {
    TaskDetailModel tdmValue = widget.tdm;

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

    return MaterialApp(
        home: Scaffold(
      body: Container(
        color: Color.fromARGB(255, 236, 255, 239),
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            // Row 1 - 40% of the screen
            Expanded(
              flex: 5,
              child: Container(
                  child: Row(
                children: [
                  Expanded(
                    child: Column(children: [
                      Center(
                        child: Text(
                          tdmValue.title,
                          style: GoogleFonts.lato(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                          color: Color.fromARGB(255, 253, 254, 255),
                          height: 272,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      'Priority :',
                                      style: GoogleFonts.lato(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '${tdmValue.priority}',
                                      style: GoogleFonts.lato(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: getColor(
                                              TaskDetailModel.getPriority(
                                                  tdmValue.priority))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Assigned Team Lead : ${tdmValue.teamAssigned}',
                                    style: GoogleFonts.lato(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Description:',
                                    style: GoogleFonts.lato(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 700,
                                    child: Text(
                                      '${tdmValue.description}',
                                      softWrap:
                                          true, // Allow wrapping to the next line
                                      // overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ))
                    ]),
                  ),
                  Expanded(
                    child: Column(children: [
                      Container(
                        color: Colors.blueGrey[100],
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: 700, // Set the desired width
                          height: 329, // Set the desired height
                          child: SizedBox(
                            height: 200,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  tdmValue.location.latitude,
                                  tdmValue.location.longitude,
                                ),
                                zoom: 14.4746,
                              ),
                              markers: <Marker>[
                                Marker(
                                  markerId: MarkerId('marker1'),
                                  position: LatLng(
                                    tdmValue.location.latitude,
                                    tdmValue.location.longitude,
                                  ),
                                  infoWindow: InfoWindow(
                                      title: 'Priority: ${tdmValue.priority}'),
                                ),
                              ].toSet(),
                            ),
                          ), // Replace Placeholder with your image widget
                        ),
                      ),
                    ]),
                  )
                ],
              )),
            ),
            // Row 2 - 60% of the screen
            Expanded(
              flex: 5,
              child: Container(
                  child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      'Progress :',
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 1200,
                  child: Center(
                    child: CustomLinearProgressIndicator(
                        currentStep: tdmValue.status),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      'Documents :',
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ])),
            ),
          ],
        ),
      ),
    ));
  }
}
