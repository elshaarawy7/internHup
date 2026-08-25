import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/auth_primary_button.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/custem_header.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/custom_auth_text_field.dart';

class RegesterPageBody extends StatelessWidget {
  const RegesterPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),

        child: Column(
          children: [
            CustemHeader(
              text: "Create account",
              subTitle: "Sign up to find your perfect internship",
            ),

            const Gap(24),

            CustomAuthTextField(
              labelText: "Full Name",
              hintText: "Enter your name",
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),

            CustomAuthTextField(
              labelText: "Email Address",
              hintText: "Enter your email",
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                }
                return null;
              },
            ),

            CustomAuthTextField(
              labelText: "Password",
              hintText: "Enter your password",
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
            ),

            CustomAuthTextField(
              labelText: "Confirm Password",
              hintText: "Enter your password",
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
            ),
            const Gap(24),

            AuthPrimaryButton(
              text: "Create account",
              onPressed: () {
                context.push(AppRouter.loginRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
