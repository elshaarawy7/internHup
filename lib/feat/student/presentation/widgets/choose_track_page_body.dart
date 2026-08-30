import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/helper/app_router.dart';

/// A reusable card representing a single internship track the user can pick
/// from. Mirrors the visual language of [AccountTypeCard] but tuned for the
/// dark onboarding theme.
class TrackCard extends StatelessWidget {
  const TrackCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: selected
                ? Colors.white.withValues(alpha: 0.10)
                : Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected
                  ? color
                  : Colors.white.withValues(alpha: 0.08),
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.55),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? color : Colors.transparent,
                  border: Border.all(
                    color: selected
                        ? color
                        : Colors.white.withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                ),
                child: selected
                    ? const Icon(Icons.check_rounded,
                        size: 14, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrackOption {
  const _TrackOption({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

class ChooseTrackPageBody extends StatefulWidget {
  const ChooseTrackPageBody({super.key});

  @override
  State<ChooseTrackPageBody> createState() => _ChooseTrackPageBodyState();
}

class _ChooseTrackPageBodyState extends State<ChooseTrackPageBody> {
  String? _selected;

  static const List<_TrackOption> _options = [
    _TrackOption(
      id: 'software',
      title: 'Software Engineering',
      description: 'Mobile, web, backend, and full-stack roles.',
      icon: Icons.code_rounded,
      color: Color(0xFF3B82F6),
    ),
    _TrackOption(
      id: 'data',
      title: 'Data & AI',
      description: 'Data science, machine learning, and analytics.',
      icon: Icons.insights_rounded,
      color: Color(0xFF8B5CF6),
    ),
    _TrackOption(
      id: 'design',
      title: 'Product Design',
      description: 'UX, UI, and product design internships.',
      icon: Icons.palette_rounded,
      color: Color(0xFFEC4899),
    ),
    _TrackOption(
      id: 'marketing',
      title: 'Marketing',
      description: 'Content, growth, and social media roles.',
      icon: Icons.campaign_rounded,
      color: Color(0xFFF59E0B),
    ),
    _TrackOption(
      id: 'business',
      title: 'Business & Finance',
      description: 'Consulting, banking, and operations roles.',
      icon: Icons.business_center_rounded,
      color: Color(0xFF10B981),
    ), 

    
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // ── top bar ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'Step 2 of 3',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── progress bar ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: 2 / 3,
                minHeight: 4,
                backgroundColor: Colors.white.withValues(alpha: 0.10),
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
                const Text(
                  'Pick your track',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose the area you want to explore. You can change this later.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.60),
                    fontSize: 14.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // ── tracks list ────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Column(
                children: [
                  for (var i = 0; i < _options.length; i++) ...[
                    TrackCard(
                      title: _options[i].title,
                      description: _options[i].description,
                      icon: _options[i].icon,
                      color: _options[i].color,
                      selected: _selected == _options[i].id,
                      onTap: () =>
                          setState(() => _selected = _options[i].id),
                    ),
                    if (i < _options.length - 1) const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          ),

          // ── continue ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _selected == null
                    ? null
                    : () {
                        // TODO: pass the selected track to the next screen
                        // (e.g. the student registration form).
                        context.push(
                          AppRouter.regesterRoute,
                          extra: _selected,
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selected == null
                      ? Colors.white.withValues(alpha: 0.10)
                      : AppColors.primColor,
                  foregroundColor: _selected == null
                      ? Colors.white.withValues(alpha: 0.45)
                      : Colors.white,
                  disabledBackgroundColor:
                      Colors.white.withValues(alpha: 0.10),
                  disabledForegroundColor:
                      Colors.white.withValues(alpha: 0.45),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_selected == null
                        ? 'Continue'
                        : 'Continue as ${_options.firstWhere((o) => o.id == _selected).title}'),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
