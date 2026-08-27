import 'package:flutter/cupertino.dart';
import 'package:intern_hup/feat/student/presentation/widgets/home_page_student_body.dart';

class HomePageStudent  extends StatelessWidget {
  const HomePageStudent({super.key}); 

  static const routeName = "/home_page_student";

  @override
  Widget build(BuildContext context) {
    return HomePageStudentBody();
  }
}