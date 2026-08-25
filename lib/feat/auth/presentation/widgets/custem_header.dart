import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intern_hup/core/constant/app_color.dart';

class CustemHeader extends StatelessWidget {
  const CustemHeader({super.key, required this.text, required this.subTitle}); 

  final String text ;
  final String subTitle ;

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),

        Text(
          text,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xff0F172A),
            letterSpacing: -0.5,
          ),
        ),

        const Gap(6),

        Text(
          subTitle,
          style: TextStyle(
            fontSize: 15,
            color: AppColors.neutralColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
  }
