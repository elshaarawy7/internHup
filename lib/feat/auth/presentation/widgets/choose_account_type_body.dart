import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/account_type_card.dart';
import 'package:intern_hup/feat/auth/presentation/widgets/auth_primary_button.dart';

/// The body of the "Choose Account Type" screen.
///
/// Manages the local selection state ([AccountType?]) and composes the
/// two [AccountTypeCard]s and the "Continue" [AuthPrimaryButton].
/// Navigation is delegated to [AppRouter] via GoRouter.
class ChooseAccountTypeBody extends StatefulWidget {
  const ChooseAccountTypeBody({super.key});

  @override
  State<ChooseAccountTypeBody> createState() => _ChooseAccountTypeBodyState();
}

class _ChooseAccountTypeBodyState extends State<ChooseAccountTypeBody>
    with SingleTickerProviderStateMixin {
  // ─── Local state ──────────────────────────────────────────────────────────

  /// Currently selected account type; `null` means nothing is chosen yet.
  AccountType? _selectedType;

  // ─── Animation controller for the header slide-in ─────────────────────────
  late final AnimationController _headerCtrl;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;

  @override
  void initState() {
    super.initState();
    _headerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _headerFade = CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOut);
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOutCubic));

    // Kick off entrance animation once the first frame is drawn.
    WidgetsBinding.instance.addPostFrameCallback((_) => _headerCtrl.forward());
  }

  @override
  void dispose() {
    _headerCtrl.dispose();
    super.dispose();
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  /// Updates the selection; calling setState triggers a rebuild so both cards
  /// and the Continue button react to the change.
  void _onSelect(AccountType type) {
    if (_selectedType == type) return; // no-op if already selected
    setState(() => _selectedType = type);
  }

  /// Routes to the correct register screen based on [_selectedType].
  void _onContinue() {
    if (_selectedType == null) return;

    final String route = _selectedType == AccountType.student
        ? AppRouter.studentRegisterRoute
        : AppRouter.companyRegisterRoute;

    context.push(route);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),

            // ── Back button ─────────────────────────────────────────────────
            _BackButton(),

            const Gap(32),

            // ── Animated header ─────────────────────────────────────────────
            FadeTransition(
              opacity: _headerFade,
              child: SlideTransition(
                position: _headerSlide,
                child: _Header(),
              ),
            ),

            const Gap(40),

            // ── Selection cards ─────────────────────────────────────────────
            AccountTypeCard(
              type: AccountType.student,
              icon: Icons.school_rounded,
              title: 'Student',
              subtitle: 'Find internships & build\nyour career.',
              isSelected: _selectedType == AccountType.student,
              onTap: () => _onSelect(AccountType.student),
            ),

            const Gap(16),

            AccountTypeCard(
              type: AccountType.company,
              icon: Icons.business_center_rounded,
              title: 'Company',
              subtitle: 'Post opportunities & discover\ntop talent.',
              isSelected: _selectedType == AccountType.company,
              onTap: () => _onSelect(AccountType.company),
            ),

            const Spacer(),

            // ── Continue button ─────────────────────────────────────────────
            // Passes `null` to [onPressed] when nothing is selected, which
            // causes [AuthPrimaryButton] to render in its disabled style.
            AuthPrimaryButton(
              text: 'Continue',
              onPressed: _selectedType != null ? _onContinue : null,
            ),

            const Gap(32),
          ],
        ),
      ),
    );
  }
}

// ─── Private sub-widgets ──────────────────────────────────────────────────────

/// Minimal back-navigation button that matches the dark-mode surface.
class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(AppRouter.loginRoute), 
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xff1E293B),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xff334155), width: 1.2),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color(0xffF1F5F9),
          size: 18,
        ),
      ),
    );
  }
}

/// Title and subtitle header section.
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Arabic subtitle (RTL hint)
        Text(
          'اختر نوع الحساب',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.primColor,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        const Gap(6),

        // English main heading
        const Text(
          'Join As',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Color(0xffF1F5F9),
            letterSpacing: -0.8,
            height: 1.1,
          ),
        ),
        const Gap(10),

        const Text(
          'Select the account type that best\ndescribes you.',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xff94A3B8),
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
