import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planner/controllers/task_controller.dart';
import 'package:planner/services/notification_services.dart';
import 'package:planner/services/theme_services.dart';
import 'package:intl/intl.dart';
import 'package:planner/ui/theme.dart';
import 'package:planner/ui/widgets/add_task_bar.dart';
import 'package:planner/ui/widgets/button.dart';
import 'package:planner/ui/widgets/task_tile.dart';

import '../models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  static int index = 0;
  final _taskController = Get.put(TaskController());

  static const List leadingIcons = [
    Icons.nightlight_round,
    Icons.wb_sunny_rounded
  ];
  static List subHeadingStyle = [subHeadingStyleLight, subHeadingStyleDark];
  static List headingStyle = [headingStyleLight, headingStyleDark];

  var hold_leadingIcon = leadingIcons[index];
  var hold_subHeadSty = subHeadingStyle[index];
  var hold_headSty = headingStyle[index];

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    NotifyHelper().initializeNotification();
    // TaskController();
    setState(() {
      print("I am in setState initState homeScreen");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          addTaskBar(),
          addDateBar(),
          const SizedBox(
            height: 15,
          ),
          showTasks(),
          // ST,
        ],
      ),
    );
  }

  appBar() {
    return AppBar(
      title: const Text(
        "Planner",
        style: TextStyle(fontSize: 20),
      ),
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          // print("Tapped");
          // NotifyHelper().scheduledNotification();

          NotifyHelper.displayNotification(
              title: "Theme Changes",
              body: Get.isDarkMode
                  ? "Activated Light Mode"
                  : "Activated Dark Theme");
          setState(() {
            index == 0 ? index = 1 : index = 0;
            ThemeService().switchTheme();
            hold_leadingIcon = leadingIcons[index];
            hold_subHeadSty = subHeadingStyle[index];
            hold_headSty = headingStyle[index];
          });
        },
        child: Icon(
          hold_leadingIcon,
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

  addTaskBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: hold_subHeadSty,
              ),
              Text(
                "Today",
                style: hold_headSty,
              )
            ],
          ),
          MyButton(
              label: "+ Add Task",
              onTap: () async {
                await Get.to(const AddTaskPage());
                _taskController.getTasks();
              })
        ],
      ),
    );
  }

  addDateBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 75,
        initialSelectedDate: DateTime.now(),
        selectionColor: Themes.primaryClr,
        selectedTextColor: Colors.white,
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  showTasks() {
    return Expanded(child: Obx(
      () {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              print(_taskController.taskList.length);
              Task task = _taskController.taskList[index];
              print(task.toJson());
              if (task.repeat == "Daily") {
                DateTime date =
                    DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                print(myTime);
                NotifyHelper().scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task);
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                          child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("A Task was Tapped");

                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      )),
                    ));
              }
              if (task.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                          child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("A Task was Tapped");

                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      )),
                    ));
              } else {
                return Container();
              }
            });
      },
    ));
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.28
            : MediaQuery.of(context).size.height * 0.36,
        color: Get.isDarkMode ? Themes.darkGreyClr : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode
                      ? Colors.grey.shade600
                      : Colors.grey.shade300),
            ),
            Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "Task Completed",
                    onTap: () {
                      _taskController.markTaskDone(task.id!);
                      _taskController.getTasks();
                      Get.back();
                    },
                    clr: Themes.bluishClr,
                    context: context),
            _bottomSheetButton(
                label: "Delete Task",
                onTap: () {
                  _taskController.delete(task);
                  Get.back();
                },
                clr: Themes.pinkClr,
                context: context),
            const SizedBox(
              height: 17,
            ),
            _bottomSheetButton(
                label: "Close",
                onTap: () {
                  Get.back();
                },
                clr: Colors.white,
                context: context,
                isClose: true),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }

  _bottomSheetButton(
      {required String label,
      required Function()? onTap,
      required Color clr,
      required BuildContext context,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color:
                  isClose ? Theme.of(context).colorScheme.inversePrimary : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClose
              ? Get.isDarkMode
                  ? Colors.transparent
                  : Theme.of(context).backgroundColor
              : Get.isDarkMode
                  ? Colors.transparent
                  : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.robotoMono(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isClose
                    ? Theme.of(context).colorScheme.inversePrimary
                    : Get.isDarkMode
                        ? clr
                        : Colors.white),
          ),
        ),
      ),
    );
  }
}
