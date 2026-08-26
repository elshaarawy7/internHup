import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/services/getit.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/regester/regester_cubit.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/regester_page_body.dart';

class RegesterPage extends StatelessWidget {
  const RegesterPage({super.key});
   
   static String regesterRoute = '/regester_page'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocProvider(
        create: (context) => getIt<RegeseterCubit>(),
        child: const RegesterPageBody(),
      ),
    )
    ;
  }
}
