import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({super.key, required this.label});
  // var payload = NotifiedPage.label
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            this.label.toString().split("|")[0],
            style: const TextStyle(fontSize: 20),
          ),
          backgroundColor: Get.isDarkMode ? Colors.grey.shade700 : Colors.white,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios))),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Get.isDarkMode ? Colors.white : Colors.grey.shade400),
          child: Center(
            child: Text(
              this.label.toString().split("|")[1],
              style: TextStyle(
                  fontSize: 30,
                  color: Get.isDarkMode ? Colors.black : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
