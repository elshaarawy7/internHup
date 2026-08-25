import 'package:flutter/material.dart';
import 'package:intern_hup/core/helper/app_router.dart';

/// Company registration screen.
///
/// Scaffold shell — company-specific form widgets will be added in a follow-up task.
class CompanyRegisterPage extends StatelessWidget {
  const CompanyRegisterPage({super.key});

  static const String routeName = AppRouter.companyRegisterRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xff0F172A),
        foregroundColor: const Color(0xffF1F5F9),
        elevation: 0,
        title: const Text(
          'Company Registration',
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
            Icon(
              Icons.business_center_rounded,
              size: 72,
              color: Color(0xff6366F1),
            ),
            SizedBox(height: 20),
            Text(
              'Company Register',
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
