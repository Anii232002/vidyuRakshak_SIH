import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vidyurakshak_web/utils/enums/priority_enum.dart';

class TaskDetailModel {
  final String title;
  final String description;
  final String teamAssigned;
  final GeoPoint location;
  final String priority;
  final bool active;
  final String status;
  String id;

  TaskDetailModel(
      {required this.title,
      required this.active,
      required this.description,
      required this.teamAssigned,
      required this.location,
      required this.priority,
      required this.status,
      required this.id});

  static setId(TaskDetailModel tdm, id) {
    tdm.id = id;
  }

  static PriorityEnum getPriority(String priority) {
    switch (priority) {
      case 'low':
        return PriorityEnum.low;
      case 'medium':
        return PriorityEnum.medium;
      case 'high':
        return PriorityEnum.high;
      default:
        return PriorityEnum.low;
    }
  }

  factory TaskDetailModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TaskDetailModel(
        title: data?['title'],
        description: data?['description'],
        teamAssigned: data?['teamAssigned'],
        location: data?['location'],
        priority: data?['priority'],
        active: data?['active'],
        status: data?['status'],
        id: data?['id']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (location != null) "location": location,
      if (teamAssigned != null) "teamAssigned": teamAssigned,
      if (active != null) "active": active,
      if (priority != null) "priority": priority,
      if (status != null) "status": status,
      if (id != null) "id": id
    };
  }
}
