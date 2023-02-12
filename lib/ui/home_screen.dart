import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planner/services/notification_services.dart';
import 'package:planner/services/theme_services.dart';
import 'package:intl/intl.dart';
import 'package:planner/ui/theme.dart';
import 'package:planner/ui/widgets/add_task_bar.dart';
import 'package:planner/ui/widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  static int index = 0;

  static const List leadingIcons = [
    Icons.nightlight_round,
    Icons.wb_sunny_rounded
  ];
  static List subHeadingStyle = [subHeadingStyleLight, subHeadingStyleDark];
  static List headingStyle = [headingStyleLight, headingStyleDark];

  var hold_leadingIcon = leadingIcons[index];
  var hold_subHeadSty = subHeadingStyle[index];
  var hold_headSty = headingStyle[index];

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
              label: "+ Add Task", onTap: () => Get.to(const AddTaskPage()))
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
          _selectedDate = date;
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    NotifyHelper().initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [addTaskBar(), addDateBar()],
      ),
    );
  }
}


// Get.isDarkMode
            //     ? subHeadTxtStyl = subHeadingStyleDark
            //     : subHeadTxtStyl = subHeadingStyleLight;
            // subHeadTxtStyl = subHeadingStyleDark;