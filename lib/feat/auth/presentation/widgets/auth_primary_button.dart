import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';

/// A reusable primary button for authentication and form screens.
///
/// Handles normal, loading, and disabled states.
/// Used across: Login, Register, Forgot Password, and other forms.
class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  bool get _isDisabled => onPressed == null || isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: _isDisabled
              ? null
              : LinearGradient(
                  colors: [
                    AppColors.primColor,
                    AppColors.primColor.withValues(blue: 230 / 255),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
          color: _isDisabled ? AppColors.primColor.withValues(alpha: 0.5) : null,
          boxShadow: _isDisabled
              ? null
              : [
                  BoxShadow(
                    color: AppColors.primColor.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onPressed ,
            splashColor: Colors.white.withValues(alpha: 0.15),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isLoading
                    ? const SizedBox(
                        key: ValueKey('loading'),
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Text(
                        key: const ValueKey('label'),
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
