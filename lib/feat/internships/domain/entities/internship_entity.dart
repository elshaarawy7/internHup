/// The business representation of a published internship.
class InternshipEntity {
  const InternshipEntity({
    this.id,
    this.companyId,
    required this.companyName,
    required this.title,
    required this.description,
    required this.location,
    required this.isPaid,
    required this.duration,
    this.requirements,
    this.deadline,
    this.createdAt,
  });

  final String? id;
  final String? companyId;
  final String companyName;
  final String title;
  final String description;
  final String location;
  final bool isPaid;
  final String duration;
  final String? requirements;
  final DateTime? deadline;
  final DateTime? createdAt;
}
