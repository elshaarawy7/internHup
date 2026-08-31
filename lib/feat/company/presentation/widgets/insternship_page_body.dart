import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_hup/core/helper/app_router.dart';
import 'package:intern_hup/feat/company/data/models/internship_model.dart';
import 'package:intern_hup/feat/internships/presentation/widgets/internship_card.dart';

class InsternshipPageBody extends StatelessWidget {
  const InsternshipPageBody({
    super.key,
    required this.internships,
    required this.isLoading,
    required this.errorMessage,
    required this.onRetry,
    required this.onDelete,
  });

  final List<InternshipModel> internships;
  final bool isLoading;
  final String? errorMessage;
  final Future<void> Function() onRetry;
  final Future<void> Function(InternshipModel internship, int index) onDelete;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const Gap(40),
            const Text(
              "Manage Internship",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Gap(16),
            const Text(
              "Create and manage your internship offers",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Gap(20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : errorMessage != null
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const Gap(12),
                          ElevatedButton(
                            onPressed: onRetry,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  : internships.isEmpty
                  ? const Center(
                      child: Text(
                        "No Internships Added Yet",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                    itemCount: internships.length,
                    itemBuilder: (context, index) {
                      final internship = internships[index];
                      return InternshipCard(
                        internship: internship,
                        isCompany: true,
                        onEdit: () => context.push(AppRouter.jopDetilsRoute),
                        onDelete: () => onDelete(internship, index),
                        onViewApplicants: () => context.push(
                          AppRouter.internshipApplicantsRoute,
                          extra: internship,
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
