import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/core/services/getit.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/login/login_cubit.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/login_page_body.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String routeName = AppRouter.loginRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocProvider(
        create: (context) => getIt<LoginCubit>() ,
        child: const LoginPageBody() , 
        ), 
    );
  }
}