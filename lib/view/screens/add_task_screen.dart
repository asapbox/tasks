import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/navigation/navigation.dart';
import 'package:intl/intl.dart';
import 'package:tasks/view_model/view_model.dart';

import '../../model/task.dart';

class AddTaskScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: Paths.addTaskScreenPath,
      key: ValueKey(Paths.addTaskScreenPath),
      child: const AddTaskScreen(),
    );
  }

  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _inputFormKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final timeStartController = TextEditingController();
  final timeEndController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    timeStartController.dispose();
    timeEndController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Add task',
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCustomForm(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: buildElevatedButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _inputFormKey,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            buildTitleField(),
            const SizedBox(
              height: 30.0,
            ),
            buildDatePicker(),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Expanded(
                  child: buildTimeStartPicker(),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(child: buildTimeEndPicker()),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            buildRemindField(),
            const SizedBox(
              height: 30.0,
            ),
            buildRepeatField(),

          ],
        ),
      ),
    );
  }

  Widget buildTitleField() {
    return TextFormField(
      minLines: 1,
      maxLines: 10,
      controller: titleController,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text('title'),
        hintText: 'Design team meeting',
      ),
    );
  }

  Widget buildDatePicker() {
    return TextFormField(
      controller: dateController,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Please enter data';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Deadline",
        suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          debugPrint('$pickedDate');
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          debugPrint(formattedDate);

          setState(() {
            dateController.text = formattedDate;
          });
        } else {
          debugPrint("Date is not selected");
        }
      },
    );
  }

  Widget buildTimeStartPicker() {
    return TextFormField(
      controller: timeStartController,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Please enter start time';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.access_time),
        labelText: "Start time",
      ),
      readOnly: true,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );

        if (pickedTime != null) {
          DateTime parsedTime =
              DateFormat.jm().parse(pickedTime.format(context).toString());

          String formattedTime = DateFormat('HH:mm').format(parsedTime);

          setState(() {
            timeStartController.text = formattedTime;
          });
        } else {
          debugPrint('Time is not selected');
        }
      },
    );
  }

  Widget buildTimeEndPicker() {
    return TextFormField(
      controller: timeEndController,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Please enter end time';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.access_time),
        labelText: "End time",
      ),
      readOnly: true,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );

        if (pickedTime != null) {
          DateTime parsedTime =
              DateFormat.jm().parse(pickedTime.format(context).toString());

          String formattedTime = DateFormat('HH:mm').format(parsedTime);

          setState(() {
            timeEndController.text = formattedTime;
          });
        } else {
          debugPrint('Time is not selected');
        }
      },
    );
  }

  Widget buildRemindField() {
    return DropdownButtonFormField<String>(
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Please choose when to remind';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Remind",
      ),
      items: const [
        DropdownMenuItem(
          value: '5 minutes early',
          child: Text('5 minutes early'),
        ),
        DropdownMenuItem(
          value: '10 minutes early',
          child: Text('10 minutes early'),
        ),
      ],
      onChanged: (value) {},
    );
  }

  Widget buildRepeatField() {
    return DropdownButtonFormField<String>(
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Please choose when to repeat';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Repeat",
      ),
      items: const [
        DropdownMenuItem(
          value: 'Daily',
          child: Text('Daily'),
        ),
        DropdownMenuItem(
          value: 'Weekly',
          child: Text('Weekly'),
        ),
      ],
      onChanged: (value) {},
    );
  }

  Widget buildElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        if (_inputFormKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Saved')),
          );
          context
              .read<TaskManager>()
              .saveData(titleController: titleController.text);

          context.read<NavigationManager>().setIsAddTaskScreen(false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please, input required info')),
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 300.0,
        height: 40.0,
        child: const Text('Create a task'),
      ),
    );
  }
}
