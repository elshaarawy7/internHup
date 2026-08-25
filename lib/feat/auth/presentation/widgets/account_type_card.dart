import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';

/// Enum representing the two supported account types.
enum AccountType { student, company }

/// A reusable, animated selection card for the "Choose Account Type" screen.
///
/// Displays an [icon], [title], and [subtitle]. When [isSelected] is `true`
/// the card renders with a primary-coloured border, a subtle glow, and a
/// checkmark badge — all animated via [AnimatedContainer].
class AccountTypeCard extends StatelessWidget {
  const AccountTypeCard({
    super.key,
    required this.type,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final AccountType type;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  // ─── Design tokens (dark-mode palette) ───────────────────────────────────
  static const Color _cardDefault = Color(0xff1E293B); // slate-800
  static const Color _cardSelected = Color(0xff0F2444); // deep-blue tint
  static const Color _textPrimary = Color(0xffF1F5F9); // slate-100
  static const Color _textSecondary = Color(0xff94A3B8); // slate-400
  static const Color _iconBgDefault = Color(0xff334155); // slate-700
  static const Color _checkBg = Color(0xff0066FF);

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        isSelected ? AppColors.primColor : const Color(0xff334155);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? _cardSelected : _cardDefault,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1.2),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primColor.withValues(alpha: 0.25),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            // ── Icon badge ──────────────────────────────────────────────────
            AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primColor.withValues(alpha: 0.18)
                    : _iconBgDefault,
                borderRadius: BorderRadius.circular(16),
                border: isSelected
                    ? Border.all(
                        color: AppColors.primColor.withValues(alpha: 0.45),
                        width: 1.2,
                      )
                    : null,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: Icon(
                  icon,
                  key: ValueKey<bool>(isSelected),
                  size: 28,
                  color: isSelected ? AppColors.primColor : _textSecondary,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // ── Text content ────────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 280),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : _textPrimary,
                      letterSpacing: -0.3,
                    ),
                    child: Text(title),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: _textSecondary,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // ── Checkmark indicator ─────────────────────────────────────────
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: isSelected
                  ? Container(
                      key: const ValueKey('check'),
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        color: _checkBg,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    )
                  : Container(
                      key: const ValueKey('empty'),
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xff475569),
                          width: 1.5,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
