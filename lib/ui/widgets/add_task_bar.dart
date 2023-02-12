import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:planner/controllers/task_controller.dart';
import 'package:planner/ui/theme.dart';
import 'package:planner/ui/widgets/button.dart';
import 'package:planner/ui/widgets/input_field.dart';

import '../../models/task.dart';
import '../../services/theme_services.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  static DateTime _selectedDate = DateTime.now();
  DateTime? _pickerDate;
  String _endTime = "11:59 PM";
  String _startTime = DateFormat("hh:mm a").format(_selectedDate);
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20, 25];
  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedColour = 0;

  final TaskController _taskController = Get.put(TaskController());
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  appBar() {
    return AppBar(
      title: const Text(
        "Planner",
        style: TextStyle(fontSize: 20),
      ),
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 24,
        ),
      ),
      actions: [
        GestureDetector(
          child: const CircleAvatar(
            backgroundImage: AssetImage("assets/images/DP2.jpg"),
          ),
          onTap: () {
            print("Tapped");
          },
        ),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }

  _getDateFromUser() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100))
        .then((_pickerDate) {
      if (_pickerDate == null) {
        return;
      }
      setState(() {
        _selectedDate = _pickerDate;
      });
    });
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePickerDial();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time Cancelled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePickerDial() {
    return showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.dial,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }

  _colourPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Colour",
          style: titleStyle,
        ),
        const SizedBox(
          height: 6,
        ),
        Wrap(
          children: List<Widget>.generate(4, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColour = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? Themes.primaryClr
                      : index == 1
                          ? Themes.pinkClr
                          : index == 2
                              ? Themes.yellowClr
                              : Themes.greenClr,
                  child: _selectedColour == index
                      ? const Icon(
                          Icons.done,
                          size: 20,
                          color: Colors.white,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      print("in 1st if");
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "All fields can't be empty",
          snackPosition: SnackPosition.BOTTOM,
          // backgroundColor: Colors.white,
          // colorText: Themes.pinkClr,
          icon: const Icon(Icons.warning_amber_rounded));
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
        task: Task(
            note: _noteController.text,
            title: _titleController.text,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime,
            remind: _selectedRemind,
            repeat: _selectedRepeat,
            color: _selectedColour,
            isCompleted: 0));
    print("My id is $value");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: appBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Task",
              style: headingStyleBoth,
            ),
            MyInputField(
              title: "Title",
              hint: "Enter your title",
              controller: _titleController,
            ),
            MyInputField(
              title: "Note",
              hint: "Enter your note",
              controller: _noteController,
            ),
            MyInputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(
                    Icons.calendar_month_rounded,
                    color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[500],
                  ),
                  onPressed: () {
                    _getDateFromUser();
                  },
                )),
            Row(
              children: [
                Expanded(
                    child: MyInputField(
                  title: "Start Time",
                  hint: _startTime,
                  widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: true);
                      },
                      icon: const Icon(Icons.access_time_rounded)),
                )),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: MyInputField(
                  title: "End Time",
                  hint: _endTime,
                  widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: false);
                      },
                      icon: const Icon(Icons.access_time_rounded)),
                ))
              ],
            ),
            MyInputField(
              title: "Remind",
              hint: "$_selectedRemind minutes early",
              widget: DropdownButton(
                menuMaxHeight: 150,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                },
                underline: Container(
                  height: 0,
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 32,
                elevation: 4,
                style: subTitleStyle,
                items: remindList.map<DropdownMenuItem<String>>((int value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text("$value minutes"),
                  );
                }).toList(),
              ),
            ),
            MyInputField(
              title: "Repeat",
              hint: _selectedRepeat,
              widget: DropdownButton(
                menuMaxHeight: 150,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRepeat = newValue!;
                  });
                },
                underline: Container(
                  height: 0,
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 32,
                elevation: 4,
                style: subTitleStyle,
                items: repeatList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colourPalette(),
                  MyButton(label: "Create Task", onTap: () => _validateData())
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
