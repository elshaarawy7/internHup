import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/account_type_card.dart';

/// Onboarding step 1 of 3 — let the user decide how they'll use InternHub.
class ChooseAccountTypePage extends StatefulWidget {
  const ChooseAccountTypePage({super.key});

  static const String routeName = AppRouter.chooseAccountTypeRoute;

  @override
  State<ChooseAccountTypePage> createState() => _ChooseAccountTypePageState();
}

class _ChooseAccountTypePageState extends State<ChooseAccountTypePage> {
  /// Holds the selected account type. `null` = no selection yet.
  String? _selected;

  void _onSelect(String value) {
    setState(() => _selected = value);
  }

  String _continueLabel() {
    switch (_selected) {
      case 'student':
        return 'Continue as Student';
      case 'company':
        return 'Continue as Company';
      default:
        return 'Continue';
    }
  }

  String _hintText() {
    switch (_selected) {
      case 'student':
        return 'Step 2: Create your student account';
      case 'company':
        return 'Step 2: Set up your company profile';
      default:
        return 'Select an account type to continue';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0F172A),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── top bar ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  _IconButton(
                    icon: Icons.arrow_back_rounded,

                    onTap: () => context.pop(),
                  ),
                  const Spacer(),
                  const _StepPill(step: 1, total: 3),
                  const Spacer(),
                  const SizedBox(width: 40), // visual balance for back button
                ],
              ),
            ),

            // ── progress bar ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: 1 / 3,
                  minHeight: 4,
                  backgroundColor: AppColors.neutralColor.withValues(
                    alpha: 0.15,
                  ),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primColor,
                  ),
                ),
              ),
            ),

            // ── header ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How will you use\nInternHub?',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      height: 1.15,
                      letterSpacing: -0.4,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose the account type that best describes you.',
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.5,
                      color: AppColors.neutralColor,
                    ),
                  ),
                ],
              ),
            ),

            // ── cards ──────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Column(
                  children: [
                    AccountTypeCard(
                      title: 'Student',
                      description:
                          'Find internships, explore opportunities, and build your career.',
                      icon: Icons.school_outlined,
                      selected: _selected == 'student',
                      onTap: () => _onSelect('student'),
                      features: const ['Apply to roles', 'Track progress'],
                    ),
                    const SizedBox(height: 14),
                    AccountTypeCard(
                      title: 'Company',
                      description:
                          'Post internship opportunities and find talented students.',
                      icon: Icons.business_outlined,
                      selected: _selected == 'company',
                      onTap: () => _onSelect('company'),
                      features: const ['Post openings', 'Review talent'],
                    ),
                  ],
                ),
              ),
            ),

            // ── footer / continue button ───────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _selected == null
                          ? null
                          : () {
                              if (_selected == 'student') {
                                context.push(AppRouter.home_page_student);
                              } else {
                                context.push(AppRouter.homeRouteCompany);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selected == null
                            ? AppColors.neutralColor.withValues(alpha: 0.25)
                            : AppColors.primColor,
                        foregroundColor: _selected == null
                            ? AppColors.neutralColor
                            : Colors.white,
                        disabledBackgroundColor: AppColors.neutralColor
                            .withValues(alpha: 0.25),
                        disabledForegroundColor: AppColors.neutralColor,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_continueLabel()),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _hintText(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.neutralColor.withValues(alpha: 0.20)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 20, color: Colors.white),
        ),
      ),
    );
  }
}

class _StepPill extends StatelessWidget {
  const _StepPill({required this.step, required this.total});
  final int step;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primColor,
        border: Border.all(
          color: AppColors.neutralColor.withValues(alpha: 0.20),
        ),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Step $step of $total',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
