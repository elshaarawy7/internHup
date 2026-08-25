import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/feat/pslash/presentation/widgets/splash_page_body.dart';

class SpalashPage extends StatelessWidget {
  const SpalashPage({super.key});
  static const String routeName = '/spalshPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SplashPageBody(),
      );
  }
}