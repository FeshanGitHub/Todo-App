import 'dart:convert';
import 'package:todoapp/app/data/services/storage/services.dart';
import 'package:get/get.dart';
import '../../../core/utils/keys.dart';
import '../../models/task.dart';

class TaskProvider {
  final storage = Get.find<StorageService>();

  List<Task> readTask() {
    var tasks = <Task>[];
    jsonDecode(storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTask(List<Task> tasks) {
    storage.write(taskKey, jsonEncode(tasks));
  }
}
