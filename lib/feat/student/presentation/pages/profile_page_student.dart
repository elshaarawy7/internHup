import 'package:flutter/cupertino.dart';
import 'package:intern_hup/feat/student/presentation/widgets/profile_page_student_body.dart';

class ProfilePageStudent extends StatelessWidget {
  const ProfilePageStudent({super.key});

  static const String routeName = "/profile_page_student";

  @override
  Widget build(BuildContext context) {
    return ProfilePageStudentBody();
  }
}