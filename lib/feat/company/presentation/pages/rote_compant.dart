import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/feat/company/presentation/pages/applecation_page.dart';
import 'package:intern_hup/feat/company/presentation/pages/dash_bourd_page.dart';
import 'package:intern_hup/feat/company/presentation/pages/intern_ship_page.dart';
import 'package:intern_hup/feat/company/presentation/pages/profile_company_page.dart';

class RootCompany extends StatefulWidget {
  RootCompany({super.key});

  static const String rootRoute = "/rootCompany";
  @override
  State<RootCompany> createState() => _RootCompanyState();
}

class _RootCompanyState extends State<RootCompany> {
  late PageController controller;
  late List<Widget> screens;

  int currentScreen = 0;

  @override
  void initState() {
    super.initState();

    screens = [
      DashBourdPage(),
      InternShipPage(),
      ApplecationPage(),
      ProfileCompanyPage(),
    ];

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
              icon: Icon(Icons.dashboard_outlined),
              label: "DashBourd",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cases_rounded),
              label: "Internship",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              label: "Applecation",
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
