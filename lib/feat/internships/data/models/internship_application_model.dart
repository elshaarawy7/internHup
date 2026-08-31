import 'package:intern_hup/feat/internships/domain/entities/internship_application_entity.dart';

class InternshipApplicationModel extends InternshipApplicationEntity {
  const InternshipApplicationModel({
    required super.id,
    required super.studentName,
    required super.studentEmail,
    required super.coverLetter,
    required super.status,
    required super.createdAt,
    super.cvPath,
    super.cvFileName,
  });

  factory InternshipApplicationModel.fromJson(Map<String, dynamic> json) {
    return InternshipApplicationModel(
      id: json['id']?.toString() ?? '',
      studentName: json['student_name']?.toString() ?? 'Unnamed student',
      studentEmail: json['student_email']?.toString() ?? '',
      coverLetter: json['cover_letter']?.toString() ?? '',
      status: json['status']?.toString() ?? 'pending',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at'].toString()),
      cvPath: json['cv_path']?.toString(),
      cvFileName: json['cv_file_name']?.toString(),
    );
  }
}
