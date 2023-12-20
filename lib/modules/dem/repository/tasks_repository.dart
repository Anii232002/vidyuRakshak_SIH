import 'dart:math';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vidyurakshak_web/modules/dem/model/task_detail_model.dart';

class TasksRepository {
  final db = FirebaseFirestore.instance;

  void addData(TaskDetailModel taskDetailModel) async {
    try {
      final docRef = db.collection("Tasks").withConverter(
            fromFirestore: TaskDetailModel.fromFirestore,
            toFirestore: (TaskDetailModel taskDetailModel, options) =>
                taskDetailModel.toFirestore(),
          );
      taskDetailModel.id = docRef.id;
      await docRef.add(taskDetailModel);
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTaskData() {
    return db.collection('Tasks').snapshots();
  }
}
