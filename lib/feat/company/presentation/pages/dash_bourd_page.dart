import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';


class DashBourdPage extends StatelessWidget {
  const DashBourdPage({super.key}); 

  static const String dashBourdRoute = "/dash_bourd_page";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
    //  body: DashBourdPageBody() , 
    );
  }
}