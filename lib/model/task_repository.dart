import 'task.dart';

class TaskRepository {
  final List<Task> tasks = [];

  TaskRepository._();

  static final TaskRepository _instance = TaskRepository._();

  factory TaskRepository() => _instance;

  @override
  String toString() {
    String output = '';
    for(final task in tasks) {
       output = '$output$task\n';
    }
    return output;
  }
}
