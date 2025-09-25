import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/presentation/screens/device_detail.dart';
import 'package:water_pump/presentation/screens/report_screen.dart';
import 'package:water_pump/presentation/screens/scheduling_screen.dart';
import 'package:water_pump/presentation/screens/settings_screen.dart';

class BottomNavScreen extends StatelessWidget{
 final controller =  Get.put(TaskController());
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        title: Text(
          "Device Detail",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged:(index) {
          controller.changeNavigation(currentIndex: index);
        },
        controller: pageController,
        children: [
            DeviceDetail(),
            SchedulingScreen(),
            ReportScreen(),
            SettingsScreen()
        ],
      ),
      bottomNavigationBar:  CurvedNavigationBar(

         // buttonBackgroundColor: Color(0xff4c8750),
        maxWidth: double.infinity,
        index: controller.index.value,
        backgroundColor: Colors.transparent,
        onTap: (i) {
          controller.changeNavigation(currentIndex: i);
          //pageController.animateToPage(i, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
       pageController.jumpToPage(i);
        },
        color: Color(0xff024a06),
        items: [
          Icon(Icons.dashboard, size: 30, color: Colors.white),
          Icon(Icons.schedule, size: 30, color: Colors.white),
          Icon(CupertinoIcons.doc_chart_fill, size: 30, color: Colors.white),
           Icon(Icons.settings, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
