import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDetailModel {
  final String title;
  final String description;
  final String teamAssigned;
  final GeoPoint latlng;
  final String priority;
  TaskDetailModel({
    required this.title,
    required this.description,
    required this.teamAssigned,
    required this.latlng,
    required this.priority,
  });

  factory TaskDetailModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TaskDetailModel(
      title: data?['title'],
      description: data?['description'],
      teamAssigned: data?['teamAssigned'],
      latlng: data?['latlng'],
      priority: data?['priority'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (latlng != null) "latlng": latlng,
      if (teamAssigned != null) "teamAssigned": teamAssigned,
      if (priority != null) "priority": priority,
    };
  }
}
