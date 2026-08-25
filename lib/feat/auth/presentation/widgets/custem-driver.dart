import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';

class CustemDriver extends StatelessWidget {
  const CustemDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: const Color(0xffE2E8F0),
            thickness: 1,
            endIndent: 12,
          ),
        ),
        Text(
          'or',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.neutralColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Divider(
            color: const Color(0xffE2E8F0),
            thickness: 1,
            indent: 12,
          ),
        ),
      ],
    );
  }
}