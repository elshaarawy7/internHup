import 'package:flutter/material.dart';
import 'package:intern_hup/core/helper/app_router.dart';

/// Student registration screen.
///
/// Scaffold shell — student-specific form widgets will be added in a follow-up task.
class StudentRegisterPage extends StatelessWidget {
  const StudentRegisterPage({super.key});

  static const String routeName = AppRouter.studentRegisterRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xff0F172A),
        foregroundColor: const Color(0xffF1F5F9),
        elevation: 0,
        title: const Text(
          'Student Registration',
          style: TextStyle(
            color: Color(0xffF1F5F9),
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_rounded, size: 72, color: Color(0xff0066FF)),
            SizedBox(height: 20),
            Text(
              'Student Register',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xffF1F5F9),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Form coming soon…',
              style: TextStyle(fontSize: 14, color: Color(0xff94A3B8)),
            ),
          ],
        ),
      ),
    );
  }
}
