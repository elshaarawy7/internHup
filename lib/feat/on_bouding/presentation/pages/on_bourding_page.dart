import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/feat/on_bouding/presentation/widgets/on_bourding_page_body.dart';

class OnBordingPage extends StatelessWidget {
  const OnBordingPage({super.key});
  static const String routeName = '/onBordingPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: OnBourdingPageBody(),
    );
  }
}