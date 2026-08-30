import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/feat/student/presentation/pages/home_page_student.dart';
import 'package:intern_hup/feat/student/presentation/pages/profile_page_student.dart';

class RootStudent extends StatefulWidget {
  RootStudent({super.key});

  static const String rootRoute = "/rootStudent";
  @override
  State<RootStudent> createState() => _RootStudentState();
}

class _RootStudentState extends State<RootStudent> {
  late PageController controller;
  late List<Widget> screens;

  int currentScreen = 0;

  @override
  void initState() {
    super.initState();

    screens = [HomePageStudent(), ProfilePageStudent()];

    controller = PageController(initialPage: currentScreen);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: screens,
        physics: const NeverScrollableScrollPhysics(),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primColor,
          unselectedItemColor: Colors.grey,
          currentIndex: currentScreen,

          onTap: (value) {
            setState(() {
              currentScreen = value;
            });

            controller.animateToPage(
              value,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },

          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
