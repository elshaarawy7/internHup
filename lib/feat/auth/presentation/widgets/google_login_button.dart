import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/constant/images_app.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/google/google_cubit.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/google/google_state.dart';

class ScoilBattonAuth extends StatelessWidget {
  const ScoilBattonAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GogooleCubit, GogooleState>(
      listener: (context, state) {
        if (state is GogooleFailure) {
          Fluttertoast.showToast(
            msg: state.fuiler,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red ,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }

        if (state is GogooleSuccess) {
          Fluttertoast.showToast(
            msg: "success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green ,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          context.push(AppRouter.chooseAccountTypeRoute) ;
        }
      },
      builder: (context, state) {
        final cubit = GogooleCubit.get(context);
        return OutlinedButton(
          onPressed: state is GogooleLoading
              ? null
              : () {
                  cubit.loginWithGogoole();
                },

          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: state is GogooleLoading ? Colors.transparent : AppColors.primColor,
              width: 2,
            ), // border أحمر
            shape: RoundedRectangleBorder( 
              borderRadius: BorderRadius.circular(
                15,
              ), // نفس شكل الـ Login button
            ),
            minimumSize: const Size(200, 50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login with Google",
                style: TextStyle(color: AppColors.primColor),
              ),

              Gap(20),
              state is GogooleLoading
                  ? CupertinoActivityIndicator(radius: 15 , color: AppColors.primColor,)
                  : Image.asset(
                    ImagesApp.googleImage , 
                      width: 20,
                      height: 20,
                    ),
            ],
          ),
        );
      },
    );
  }
}