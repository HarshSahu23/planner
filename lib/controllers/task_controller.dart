import 'package:get/get.dart';
import 'package:planner/db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  void getTasks() async {
    print("waiting for DBHelper.query");
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    print("Assigning values to task list");
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
    print("values to task list finished assigning");
  }

  void delete(Task task) {
    var deleteVal = DBHelper.delete(task);
    print("$deleteVal row deleted");
    getTasks();
  }

  void markTaskDone(int id) async {
    int rA = await DBHelper.update(id);
    print("Updated successfully");
    print("$rA rows affected");
    // getTasks();
    print("task reobtained after updation");
  }
}
