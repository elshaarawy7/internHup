import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/login/login_cubit.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/login/login_state.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/auth_primary_button.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/custem-driver.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/custem_header.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/custom_auth_text_field.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/google_login_button.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/register_prompt.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/remember_me_widgets.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Fluttertoast.showToast(
            msg: "Login Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );  

          context.push(AppRouter.chooseAccountTypeRoute) ;

          
        } 

        if (state is LoginFailure) {
            Fluttertoast.showToast(
              msg: "Login Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
      },
      builder: (context, state) {
        final cubit = LoginCubit.get(context);

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header ────────────────────────────────────────────
                  CustemHeader(
                    text: "Welcome Back",
                    subTitle: "Sign in to continue your internship search.",
                  ),

                  const Gap(32),

                  // ── Email Field ───────────────────────────────────────
                  CustomAuthTextField(
                    labelText: 'Email Address',
                    hintText: 'Enter your email address',
                    controller: cubit.emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.neutralColor,
                      size: 20,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email address.';
                      }
                      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                      if (!emailRegex.hasMatch(value.trim())) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                  ),

                  const Gap(20),

                  // ── Password Field ────────────────────────────────────
                  CustomAuthTextField(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    controller: cubit.passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: AppColors.neutralColor,
                      size: 20,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.neutralColor,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password.';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters.';
                      }
                      return null;
                    },
                  ),

                  const Gap(16),

                  // ── Remember Me / Forgot Password ─────────────────────
                  RememberMeWidgets(),

                  const Gap(28),

                  // ── Login Button ──────────────────────────────────────
                  state is LoginLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primColor,
                          ),
                        )
                      : AuthPrimaryButton(
                          text: 'Login →',
                          onPressed: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.login();
                            }
                          },
                        ),

                  const Gap(24),

                  CustemDriver(),

                  const Gap(24),

                  GoogleLoginButton(onPressed: () {}),

                  const Gap(32),
                  RegisterPrompt(
                    onTap: () {
                      context.push(AppRouter.regesterRoute);
                    },
                    text: "Register",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
