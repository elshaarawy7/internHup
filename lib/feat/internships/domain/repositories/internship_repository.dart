import 'package:dartz/dartz.dart';
import 'package:intern_hup/core/error/failure.dart';
import 'package:intern_hup/feat/internships/domain/entities/internship_entity.dart';

abstract class InternshipRepository {
  Future<Either<Failure, List<InternshipEntity>>> getInternships();
}
