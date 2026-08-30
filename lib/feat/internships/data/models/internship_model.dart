import 'package:intern_hup/feat/internships/domain/entities/internship_entity.dart';

class InternshipModel extends InternshipEntity {
  const InternshipModel({
    super.id,
    super.companyId,
    required super.companyName,
    required super.title,
    required super.description,
    required super.location,
    required super.isPaid,
    required super.duration,
    super.requirements,
    super.deadline,
    super.createdAt,
  });

  factory InternshipModel.fromJson(Map<String, dynamic> json) {
    return InternshipModel(
      id: json['id']?.toString(),
      companyId: json['company_id']?.toString(),
      companyName: json['company_name']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      isPaid: json['is_paid'] as bool? ?? false,
      duration: json['duration']?.toString() ?? '',
      requirements: json['requirements']?.toString(),
      deadline: _parseDate(json['deadline']),
      createdAt: _parseDate(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'company_id': companyId,
      'company_name': companyName,
      'title': title,
      'description': description,
      'location': location,
      'is_paid': isPaid,
      'duration': duration,
      'requirements': requirements,
      'deadline': deadline?.toIso8601String(),
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }
}
