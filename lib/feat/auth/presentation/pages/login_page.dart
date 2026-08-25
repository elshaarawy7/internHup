import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/login_page_body.dart';

/// The Login screen.
///
/// Provides the [Scaffold] shell. All UI composition lives in [LoginPageBody].
/// Authentication logic will be wired through [LoginCubit] in a later task.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  /// Matches [AppRouter.loginRoute] — used for GoRouter navigation.
  static const String routeName = AppRouter.loginRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: const LoginPageBody(),
    );
  }
}