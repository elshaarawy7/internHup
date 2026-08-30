import 'package:flutter/material.dart';

class ApplecationPage extends StatelessWidget {
  const ApplecationPage({super.key});

  static const String applecationRoute = "/applecation_page";

  @override
  Widget build(BuildContext context) {
    // ApplecationPageBody owns the dashboard Scaffold to avoid nested Scaffolds.
    return const Scaffold(
    //  body: ApplecationPageBody(),
      );
  }
}
