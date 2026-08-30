import 'package:intern_hup/feat/internships/domain/entities/internship_entity.dart';

sealed class InternshipState {
  const InternshipState();
}

class InternshipInitial extends InternshipState {
  const InternshipInitial();
}

class InternshipLoading extends InternshipState {
  const InternshipLoading();
}

class InternshipSuccess extends InternshipState {
  const InternshipSuccess(this.internships);

  final List<InternshipEntity> internships;
}

class InternshipError extends InternshipState {
  const InternshipError(this.message);

  final String message;
}
