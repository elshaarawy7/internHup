import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';

class ProfileCompanyPage extends StatelessWidget {
  const ProfileCompanyPage({super.key}); 

  static const String profileCompanyRoute = "/profile_company_page"; 

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
     // body:// ProfileCompanyPageBody() , 
    );
  }
}