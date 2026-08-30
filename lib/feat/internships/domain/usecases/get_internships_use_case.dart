import 'package:dartz/dartz.dart';
import 'package:intern_hup/core/error/failure.dart';
import 'package:intern_hup/feat/internships/domain/entities/internship_entity.dart';
import 'package:intern_hup/feat/internships/domain/repositories/internship_repository.dart';

class GetInternshipsUseCase {
  const GetInternshipsUseCase(this._repository);

  final InternshipRepository _repository;

  Future<Either<Failure, List<InternshipEntity>>> call() {
    return _repository.getInternships();
  }
}
