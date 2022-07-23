import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/view_model/view_model.dart';

class TaskList extends StatefulWidget {
  TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late ScrollController _verticalScrollController;
  late ScrollController _horizontalScrollController;

  final taskManager = TaskManager();

  @override
  void initState() {
    super.initState();
    _verticalScrollController = ScrollController();
    _horizontalScrollController = ScrollController();
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            // margin: const EdgeInsets.symmetric(vertical: 0.0),
            height: 50.0,
            child: buildListViewHorizontal(),
          ),
          Expanded(child: buildListViewSeparated()),
          ElevatedButton(
            onPressed: () {
              context.read<NavigationManager>().setIsAddTaskScreen(true);
            },
            child: Container(
              alignment: Alignment.center,
              width: 300.0,
              height: 40.0,
              child: const Text('Add a task'),
            ),
          ),
          const SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }

  Widget buildListViewHorizontal() {
    return Consumer<TaskManager>(
      builder: (context, state, child) {
        return ListView(
          scrollDirection: Axis.horizontal,
          controller: _horizontalScrollController,
          // shrinkWrap: true,
          children: <Widget>[
            const SizedBox(
              width: 10.0,
            ),
            Container(
              alignment: Alignment.center,
              decoration: state.isAllSelected
                  ? const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blue,
                          width: 3.0,
                        ),
                      ),
                    )
                  : null,
              child: TextButton(
                onPressed: () {
                  state.setIsTaskCompleted(null);
                  state.resetSelectedStatus();
                  state.isAllSelected = true;
                },
                child: const Text('All'),
              ),
            ),
            const SizedBox(
              width: 30.0,
            ),
            Container(
              alignment: Alignment.center,
              decoration: state.isCompletedSelected
                  ? const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blue,
                          width: 3.0,
                        ),
                      ),
                    )
                  : null,
              child: TextButton(
                onPressed: () {
                  state.setIsTaskCompleted(true);
                  state.resetSelectedStatus();
                  state.isCompletedSelected = true;
                },
                child: const Text('Completed'),
              ),
            ),
            const SizedBox(
              width: 40.0,
            ),
            Container(
              alignment: Alignment.center,
              decoration: state.isUncompletedSelected
                  ? const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blue,
                          width: 3.0,
                        ),
                      ),
                    )
                  : null,
              child: TextButton(
                onPressed: () {
                  state.setIsTaskCompleted(false);
                  state.resetSelectedStatus();
                  state.isUncompletedSelected = true;
                },
                child: const Text('Uncompleted'),
              ),
            ),
            const SizedBox(
              width: 40.0,
            ),
            Container(
              alignment: Alignment.center,
              decoration: state.isFavoriteSelected
                  ? const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blue,
                          width: 3.0,
                        ),
                      ),
                    )
                  : null,
              child: TextButton(
                onPressed: () {
                  state.setIsFavorite(true);
                  state.resetSelectedStatus();
                  state.isFavoriteSelected = true;
                },
                child: const Text('Favorite'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildListViewSeparated() {
    return Consumer<TaskManager>(
      builder: (context, state, child) {
        return Scrollbar(
          thumbVisibility: true,
          trackVisibility: false,
          controller: _verticalScrollController,
          child: ListView.separated(
            // primary: false,
            scrollDirection: Axis.vertical,
            controller: _verticalScrollController,
            // shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(
              height: 4.0,
            ),
            itemCount: state.fetchFilteredTasks.length,
            itemBuilder: (context, index) => Row(
              children: [
                Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  fillColor: (state.fetchFilteredTasks[index].isCompleted)
                      ? MaterialStateProperty.all(Colors.greenAccent)
                      : MaterialStateProperty.all(Colors.redAccent),
                  value: state.fetchFilteredTasks[index].isCompleted,
                  onChanged: (newValue) {
                    setState(() {
                      state.fetchFilteredTasks[index].isCompleted = newValue!;
                    });
                  },
                ),
                Flexible(child: Text(state.fetchFilteredTasks[index].title)),
              ],
            ),
          ),
        );
      },
    );
  }
}
