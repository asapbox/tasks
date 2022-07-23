import 'package:flutter/material.dart';
import 'package:tasks/model/model.dart';

class TaskManager extends ChangeNotifier {
  final tasks = TaskRepository().tasks;

  bool? isTaskCompleted;
  bool? isFavorite;

  bool isAllSelected = true;
  bool isCompletedSelected = false;
  bool isUncompletedSelected = false;
  bool isFavoriteSelected = false;

  void saveData({
    required String titleController,
  }) {
    tasks.add(
      Task(
        title: titleController,
        dueOn: DateTime.parse('2022-08-02T00:00:00.000+05:30'),
        status: 'pending',
      ),
    );
    notifyListeners();
    debugPrint(tasks.toString());
  }

  void resetSelectedStatus() {
    isAllSelected = false;
    isCompletedSelected = false;
    isUncompletedSelected = false;
    isFavoriteSelected = false;
    notifyListeners();
  }

  void setIsTaskCompleted(bool? isTaskCompleted) {
    this.isTaskCompleted = isTaskCompleted;
    isFavorite = null;
    notifyListeners();
    debugPrint('isTaskCompleted = ${this.isTaskCompleted}');
  }

  void setIsFavorite(bool? isFavorite) {
    this.isFavorite = isFavorite;
    isTaskCompleted = null;
    notifyListeners();
    debugPrint('isFavorite = ${this.isFavorite}');
  }

  List<Task> get fetchTasks {
    return tasks;
  }

  List<Task> get fetchFilteredTasks {
    final List<Task> filteredTasks = <Task>[];

    if (isTaskCompleted != null) {
      for (final task in tasks) {
        if (task.isCompleted == isTaskCompleted) {
          filteredTasks.add(task);
        }
      }
      return filteredTasks;
    } else if (isFavorite != null) {
      for (final task in tasks) {
        if (task.isFavorite == isFavorite) {
          filteredTasks.add(task);
        }
      }
      return filteredTasks;
    } else {
      return tasks;
    }
  }

  List<Task> get fetchFavorites {
    final List<Task> filteredTasks = <Task>[];

    for (final task in tasks) {
      if (task.isFavorite) {
        filteredTasks.add(task);
      }
    }
    return filteredTasks;
  }
}
