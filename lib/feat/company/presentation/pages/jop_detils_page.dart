import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/feat/company/presentation/widgets/intership_detils_page_body.dart';

class JopDetilsPage extends StatelessWidget {
  const JopDetilsPage({super.key});

  static const String jopDetilsRoute = "/jopDetils";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: InternshipDetilsPageBody(),
    );
  }
}
