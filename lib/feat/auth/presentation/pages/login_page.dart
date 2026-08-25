import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
   static const String routeName = '/loginPage';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:AppColors.backgroundColor ,
      body: LoginPageBody() , 
    );
  }
}