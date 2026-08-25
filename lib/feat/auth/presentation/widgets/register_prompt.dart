import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';

/// A reusable registration prompt widget shown at the bottom of auth screens.
///
/// Displays "Don't have an account? Register" with the "Register" text
/// styled in the app's primary color and made tappable.
///
/// This widget is extracted for reuse across multiple authentication screens.
class RegisterPrompt extends StatelessWidget {
  const RegisterPrompt({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xff64748B),
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: TextButton(
            onPressed: onTap,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primColor,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
