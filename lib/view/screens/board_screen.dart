import 'package:flutter/material.dart';
import 'package:tasks/navigation/navigation.dart';
import 'package:tasks/view/widgets/widgets.dart';

class BoardScreen extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: Paths.boardScreenPath,
      key: ValueKey(Paths.boardScreenPath),
      child: BoardScreen(),
    );
  }

  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
          child: Text(
            'Board',
            // style: Theme.of(context).textTheme.headline5,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notification_add_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: TaskList(),
    );
  }
}
