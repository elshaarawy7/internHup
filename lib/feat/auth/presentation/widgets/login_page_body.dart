import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/auth_primary_button.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/custem-driver.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/custem_header.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/custom_auth_text_field.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/google_login_button.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/register_prompt.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/remember_me_widgets.dart';

/// The main body of the Login screen.
///
/// Composes reusable auth widgets into the full login layout.
/// Password visibility state and form key live here because they belong to
/// this screen's presentation logic.
///
/// Authentication logic will later be moved to [LoginCubit].
class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 

 

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Form(
          key: _formKey,
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
                hintText: 'student@university.edu',
                controller: _emailController,
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
                hintText: '••••••••',
                controller: _passwordController,
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
              AuthPrimaryButton(
                text: 'Login →',
                onPressed: () {
                  context.push(AppRouter.chooseAccountTypeRoute);
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
  }
}
