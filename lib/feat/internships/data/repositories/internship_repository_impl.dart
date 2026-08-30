import 'package:dartz/dartz.dart';
import 'package:intern_hup/core/error/exption.dart';
import 'package:intern_hup/core/error/failure.dart';
import 'package:intern_hup/feat/internships/data/datasources/internship_remote_data_source.dart';
import 'package:intern_hup/feat/internships/domain/entities/internship_entity.dart';
import 'package:intern_hup/feat/internships/domain/repositories/internship_repository.dart';

class InternshipRepositoryImpl implements InternshipRepository {
  InternshipRepositoryImpl(this._remoteDataSource);

  final InternshipRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<InternshipEntity>>> getInternships() async {
    try {
      final internships = await _remoteDataSource.getInternships();
      return Right(internships);
    } on CustomException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(ServerFailure('Unable to load internships.'));
    }
  }
}
