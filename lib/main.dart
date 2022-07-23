import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/view_model/view_model.dart';
import 'package:tasks/navigation/navigation.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<TaskManager>(
        create: (context) => TaskManager(),
      ),
      ChangeNotifierProvider<NavigationManager>(
        create: (context) => NavigationManager(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      primarySwatch: Colors.blue,
      ),
      home: Router(
        routerDelegate: _appRouterDelegate,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
