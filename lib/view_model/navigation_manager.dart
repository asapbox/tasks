import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tasks/apis/apis.dart';

class NavigationManager extends ChangeNotifier {
  bool isInitialized = false;
  bool isBoardScreen = false;
  bool isAddTaskScreen = false;

  // final persistenceManager = PersistenceManager();
  final taskService = TaskService();

  void setIsBoardScreen(bool isActive) {
    isBoardScreen = isActive;
    notifyListeners();
    debugPrint('${DateTime.now()} - isBoardScreen = $isBoardScreen');
  }

  void setIsAddTaskScreen(bool isActive) {
    isAddTaskScreen = isActive;
    notifyListeners();
    debugPrint('${DateTime.now()} - isAddTaskScreen = $isAddTaskScreen');
  }

  void setInitialized() {
    isInitialized = true;
    notifyListeners();
    debugPrint('${DateTime.now()} - isInitialized = $isInitialized');
  }

  Future<void> initializingApp() async {
    await taskService.fetchTasks();

    await Future<void>.delayed(
      const Duration(milliseconds: 1000),
      () {
        setInitialized();
      },
    );
  }
}
