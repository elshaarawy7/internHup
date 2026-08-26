import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/regester/regeseter_state.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/regester/regester_cubit.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/auth_primary_button.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/custem_header.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/custom_auth_text_field.dart';

class RegesterPageBody extends StatefulWidget {
  const RegesterPageBody({super.key});

  @override
  State<RegesterPageBody> createState() => _RegesterPageBodyState();
}

class _RegesterPageBodyState extends State<RegesterPageBody> {
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegeseterCubit, RegeseterState>(
      listener: (context, state) {
        if (state is RegeseterSuccess) {
          Fluttertoast.showToast(
            msg: 'Account created successfully.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          context.go(AppRouter.chooseAccountTypeRoute);
        } else if (state is RegeseterFailure) {
          Fluttertoast.showToast(
            msg: state.fuiler.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      },
      builder: (context, state) {
        final cubit = RegeseterCubit.get(context);
        final isLoading = state is RegeseterLoading;

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustemHeader(
                    text: 'Create account',
                    subTitle: 'Sign up to find your perfect internship.',
                  ),
                  const Gap(32),
                  CustomAuthTextField(
                    labelText: 'Full name',
                    hintText: 'Enter your full name',
                    controller: cubit.nameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: AppColors.neutralColor,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your full name.';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CustomAuthTextField(
                    labelText: 'Email address',
                    hintText: 'Enter your email address',
                    controller: cubit.emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.neutralColor,
                    ),
                    validator: (value) {
                      final email = value?.trim() ?? '';
                      if (email.isEmpty) {
                        return 'Please enter your email address.';
                      }
                      if (!RegExp(
                        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                      ).hasMatch(email)) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CustomAuthTextField(
                    labelText: 'Password',
                    hintText: 'Create a password',
                    controller: cubit.passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: AppColors.neutralColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password.';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters.';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CustomAuthTextField(
                    labelText: 'Confirm password',
                    hintText: 'Re-enter your password',
                    controller: cubit.confirmPasswordController,
                    obscureText: _obscureConfirmation,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: AppColors.neutralColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => setState(
                        () => _obscureConfirmation = !_obscureConfirmation,
                      ),
                      icon: Icon(
                        _obscureConfirmation
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password.';
                      }
                      if (value != cubit.passwordController.text) {
                        return 'Passwords do not match.';
                      }
                      return null;
                    },
                  ),
                  const Gap(28),
                  AuthPrimaryButton(
                    text: 'Create account',
                    isLoading: isLoading,
                    onPressed: isLoading
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            cubit.regeseter();
                          },
                  ),
                  const Gap(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Color(0xff64748B)),
                      ),
                      TextButton(
                        onPressed: () => context.go(AppRouter.loginRoute),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: AppColors.primColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
