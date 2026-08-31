import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/internships/data/models/internship_application_model.dart';
import 'package:intern_hup/feat/internships/domain/entities/internship_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InternshipApplicantsPage extends StatefulWidget {
  const InternshipApplicantsPage({super.key, required this.internship});

  final InternshipEntity internship;

  @override
  State<InternshipApplicantsPage> createState() =>
      _InternshipApplicantsPageState();
}

class _InternshipApplicantsPageState extends State<InternshipApplicantsPage> {
  late Future<List<InternshipApplicationModel>> _applicantsFuture;

  @override
  void initState() {
    super.initState();
    _applicantsFuture = _getApplicants();
  }

  Future<List<InternshipApplicationModel>> _getApplicants() async {
    final internshipId = widget.internship.id;
    if (internshipId == null) return const [];
    final response = await Supabase.instance.client
        .from('internship_applications')
        .select(
          'id, student_name, student_email, cover_letter, cv_path, '
          'cv_file_name, status, created_at',
        )
        .eq('internship_id', internshipId)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map(
          (item) => InternshipApplicationModel.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();
  }

  void _reload() {
    setState(() => _applicantsFuture = _getApplicants());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Applicants'),
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
      body: FutureBuilder<List<InternshipApplicationModel>>(
        future: _applicantsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return _ApplicantsLoadError(onRetry: _reload);
          }
          final applicants = snapshot.data ?? const [];
          if (applicants.isEmpty) {
            return const Center(
              child: Text('No one has applied for this internship yet.'),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => _reload(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: applicants.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final applicant = applicants[index];
                return _ApplicantCard(
                  applicant: applicant,
                  onTap: () => context.push(
                    AppRouter.applicantDetailsRoute,
                    extra: applicant,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _ApplicantCard extends StatelessWidget {
  const _ApplicantCard({required this.applicant, required this.onTap});

  final InternshipApplicationModel applicant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE6EAF0)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x080F172A),
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      _initials(applicant.studentName),
                      style: const TextStyle(
                        color: AppColors.primColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          applicant.studentName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          applicant.studentEmail,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      size: 15, color: Color(0xFF94A3B8)),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(height: 1, color: Color(0xFFE8ECF2)),
              const SizedBox(height: 12),
              Row(
                children: [
                  _StatusPill(status: applicant.status),
                  const Spacer(),
                  const Icon(Icons.calendar_today_outlined,
                      size: 15, color: Color(0xFF64748B)),
                  const SizedBox(width: 5),
                  Text(
                    _formatDate(applicant.createdAt),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E6),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        status.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
          color: Color(0xFFB45309),
        ),
      ),
    );
  }
}

class _ApplicantsLoadError extends StatelessWidget {
  const _ApplicantsLoadError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 38),
            const SizedBox(height: 12),
            const Text(
              'Could not load applicants. Make sure the applications migration '
              'has been run in Supabase.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}

String _initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty);
  return parts.take(2).map((part) => part[0].toUpperCase()).join();
}

String _formatDate(DateTime? date) {
  if (date == null) return 'Applied date unavailable';
  final localDate = date.toLocal();
  return '${localDate.year}-${localDate.month.toString().padLeft(2, '0')}-${localDate.day.toString().padLeft(2, '0')}';
}
