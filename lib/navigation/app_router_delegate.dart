import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tasks/navigation/paths.dart';
import 'package:tasks/view_model/view_model.dart';
import 'package:tasks/view/screens/screens.dart';

class AppRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  TaskManager taskManager = TaskManager();

  @override
  GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: (Route<dynamic> route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        if (route.settings.name == Paths.addTaskScreenPath) {
          context.read<NavigationManager>().setIsAddTaskScreen(false);
        }
        return true;
      },
      pages: [
        if (!context.watch<NavigationManager>().isInitialized) ...[
          SplashScreen.page(),
        ] else ...[
          BoardScreen.page(),
          if (context.watch<NavigationManager>().isAddTaskScreen)
            AddTaskScreen.page(),
        ]
      ],
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
