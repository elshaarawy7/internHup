class InternshipApplicationEntity {
  const InternshipApplicationEntity({
    required this.id,
    required this.studentName,
    required this.studentEmail,
    required this.coverLetter,
    required this.status,
    required this.createdAt,
    this.cvPath,
    this.cvFileName,
  });

  final String id;
  final String studentName;
  final String studentEmail;
  final String coverLetter;
  final String status;
  final DateTime? createdAt;
  final String? cvPath;
  final String? cvFileName;
}
