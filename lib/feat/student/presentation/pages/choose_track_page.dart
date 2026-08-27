import 'package:flutter/material.dart';
import 'package:intern_hup/feat/student/presentation/widgets/choose_track_page_body.dart';

class ChooseTrackPage extends StatelessWidget {
  const ChooseTrackPage({super.key});

  static const String chooseTrackRoute = "/choose_track";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff0F172A),
      body: ChooseTrackPageBody(),
    );
  }
}
