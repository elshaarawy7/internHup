import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';
import 'package:intern_hup/feat/internships/domain/entities/internship_entity.dart';

/// A single internship offer. Available actions depend on the viewing account.
class InternshipCard extends StatelessWidget {
  const InternshipCard({
    super.key,
    required this.internship,
    required this.isCompany,
    this.onApply,
    this.onEdit,
    this.onDelete,
    this.onViewApplicants,
  });

  final InternshipEntity internship;
  final bool isCompany;
  final VoidCallback? onApply;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onViewApplicants;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  internship.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (isCompany)
                IconButton(
                  tooltip: 'Delete internship',
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
            ],
          ),
          Text(
            internship.companyName.isEmpty
                ? 'Company name not specified'
                : internship.companyName,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            internship.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF475569), height: 1.35),
          ),
          const SizedBox(height: 14),
          _DetailRow(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: internship.location,
          ),
          const SizedBox(height: 8),
          _DetailRow(
            icon: Icons.access_time_outlined,
            label: 'Duration',
            value: _valueOrFallback(internship.duration),
          ),
          const SizedBox(height: 8),
          _DetailRow(
            icon: Icons.event_available_outlined,
            label: 'Apply before',
            value: _formatDeadline(internship.deadline),
          ),
          const SizedBox(height: 14),
          const Text(
            'Requirements',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            _valueOrFallback(internship.requirements),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF475569), height: 1.35),
          ),
          if (internship.isPaid) ...[
            const SizedBox(height: 14),
            const _PaidChip(),
          ],
          const SizedBox(height: 18),
          const Divider(height: 1),
          const SizedBox(height: 14),
          if (isCompany) _CompanyActions(
            onEdit: onEdit,
            onViewApplicants: onViewApplicants,
            applicantCount: internship.applicantCount,
          ) else SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onApply,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Apply now'),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyActions extends StatelessWidget {
  const _CompanyActions({
    this.onEdit,
    this.onViewApplicants,
    required this.applicantCount,
  });

  final VoidCallback? onEdit;
  final VoidCallback? onViewApplicants;
  final int applicantCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: OutlinedButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: const Text('Edit'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: onViewApplicants,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.groups_outlined, size: 18),
                  const SizedBox(width: 6),
                  Text('View applicants ($applicantCount)'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF64748B)),
        const SizedBox(width: 7),
        Expanded(
          child: Text.rich(
            TextSpan(
              style: const TextStyle(color: Color(0xFF475569)),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PaidChip extends StatelessWidget {
  const _PaidChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFA7F3D0)),
      ),
      child: const Text(
        'Paid',
        style: TextStyle(
          color: Color(0xFF047857),
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}

String _valueOrFallback(String? value) {
  return value?.trim().isNotEmpty == true ? value!.trim() : 'Not specified';
}

String _formatDeadline(DateTime? deadline) {
  if (deadline == null) return 'Not specified';
  final localDeadline = deadline.toLocal();
  final hour = localDeadline.hour % 12 == 0 ? 12 : localDeadline.hour % 12;
  final period = localDeadline.hour >= 12 ? 'PM' : 'AM';
  return '${localDeadline.year}-${localDeadline.month.toString().padLeft(2, '0')}-${localDeadline.day.toString().padLeft(2, '0')} '
      '${hour.toString().padLeft(2, '0')}:${localDeadline.minute.toString().padLeft(2, '0')} $period';
}
