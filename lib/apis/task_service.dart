import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tasks/model/model.dart';
import 'dart:io';

class TaskService {
  final String taskUrl = 'https://gorest.co.in/public/v2/todos';

  // Future<bool> checkingInternetConnection() async {
  //   try {
  //     final result = await InternetAddress.lookup('gorest.co.in');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } on SocketException catch (_) {
  //     return false;
  //   }
  // }

  Future<void> fetchTasks() async {
    final response = await http.get(Uri.parse(taskUrl));

    if (response.statusCode == 200) {
      final decodedString = jsonDecode(response.body) as List<dynamic>;

      for (final decodedTask in decodedString) {
        TaskRepository().tasks.add(Task.fromApiJson(decodedTask));
      }
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}

// Future<void> main() async {
//   await TaskService().fetchTasks();
//   print(TaskRepository());
// }
