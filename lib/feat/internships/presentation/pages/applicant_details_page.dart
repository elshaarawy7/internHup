import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/feat/internships/domain/entities/internship_application_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicantDetailsPage extends StatefulWidget {
  const ApplicantDetailsPage({super.key, required this.applicant});

  final InternshipApplicationEntity applicant;

  @override
  State<ApplicantDetailsPage> createState() => _ApplicantDetailsPageState();
}

class _ApplicantDetailsPageState extends State<ApplicantDetailsPage> {
  bool _isOpeningCv = false;

  Future<void> _openCv() async {
    final cvPath = widget.applicant.cvPath;
    if (cvPath == null || cvPath.isEmpty) {
      _showMessage('This applicant did not upload a CV.', isError: true);
      return;
    }
    setState(() => _isOpeningCv = true);
    try {
      final signedUrl = await Supabase.instance.client.storage
          .from('cvs')
          .createSignedUrl(cvPath, 60);
      final didOpen = await launchUrl(
        Uri.parse(signedUrl),
        mode: LaunchMode.externalApplication,
      );
      if (!didOpen && mounted) {
        _showMessage('Could not open the CV file.', isError: true);
      }
    } on StorageException catch (error) {
      if (mounted) _showMessage(error.message, isError: true);
    } catch (_) {
      if (mounted) _showMessage('Could not open the CV file.', isError: true);
    } finally {
      if (mounted) setState(() => _isOpeningCv = false);
    }
  }

  void _showMessage(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: isError ? Colors.red : Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    final applicant = widget.applicant;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Applicant details'),
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.primColor,
                child: Text(
                  _detailsInitials(applicant.studentName),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                applicant.studentName,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 24),
            _InformationCard(
              icon: Icons.email_outlined,
              title: 'Email address',
              value: applicant.studentEmail,
            ),
            const SizedBox(height: 12),
            _InformationCard(
              icon: Icons.pending_actions_outlined,
              title: 'Application status',
              value: applicant.status,
            ),
            const SizedBox(height: 12),
            _InformationCard(
              icon: Icons.calendar_today_outlined,
              title: 'Applied on',
              value: _detailsDate(applicant.createdAt),
            ),
            const SizedBox(height: 24),
            const Text(
              'Cover letter',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                applicant.coverLetter.isEmpty
                    ? 'No cover letter was provided.'
                    : applicant.coverLetter,
                style: const TextStyle(height: 1.45, color: Color(0xFF475569)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isOpeningCv ? null : _openCv,
                icon: _isOpeningCv
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.description_outlined),
                label: Text(
                  _isOpeningCv
                      ? 'Opening CV...'
                      : applicant.cvFileName == null
                      ? 'CV not uploaded'
                      : 'Open CV: ${applicant.cvFileName}',
                  overflow: TextOverflow.ellipsis,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InformationCard extends StatelessWidget {
  const _InformationCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Color(0xFF64748B))),
                const SizedBox(height: 3),
                Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _detailsInitials(String name) {
  final parts = name.trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty);
  return parts.take(2).map((part) => part[0].toUpperCase()).join();
}

String _detailsDate(DateTime? date) {
  if (date == null) return 'Not available';
  final localDate = date.toLocal();
  return '${localDate.year}-${localDate.month.toString().padLeft(2, '0')}-${localDate.day.toString().padLeft(2, '0')}';
}
