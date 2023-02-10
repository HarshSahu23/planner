import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planner/services/notification_services.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:planner/services/theme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    NotifyHelper().initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: const [
          Text(
            "ABC",
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }
}

_appBar() {
  return AppBar(
    title: Text("Planner"),
    leading: GestureDetector(
      child: const Icon(
        Icons.nightlight_round,
        size: 20,
      ),
      onTap: () {
        // print("Tapped");
        ThemeService().switchTheme();
        NotifyHelper.displayNotification(
            title: "Theme Changes",
            body: Get.isDarkMode
                ? "Activated Light Mode"
                : "Activated Dark Theme");
        NotifyHelper().scheduledNotification();
      },
    ),
    actions: [
      GestureDetector(
        child: const Icon(
          Icons.person,
          size: 20,
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
