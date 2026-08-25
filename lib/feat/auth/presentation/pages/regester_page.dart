import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/regester_page_body.dart';

class RegesterPage extends StatelessWidget {
  const RegesterPage({super.key});
   
   static String regesterRoute = '/regester_page'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: RegesterPageBody(),
    )
    ;
  }
}