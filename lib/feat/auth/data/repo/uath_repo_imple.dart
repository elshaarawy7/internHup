import 'package:dartz/dartz.dart';
import 'package:intern_hup/core/error/fuiler.dart';
import 'package:intern_hup/feat/auth/data/datasources/user_datasource.dart';
import 'package:intern_hup/feat/auth/data/repo/auth_repo.dart';
import 'package:intern_hup/feat/auth/domain/entity/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl implements AuthRepo {
  final UserDataSource userDataSource;

  AuthRepoImpl(this.userDataSource,);

  @override
  Future<Either<Fuiler, UserEntity>> login(String email, String password) async {
    try {
      final result = await userDataSource.login(email, password);
      return Right(result);
    } catch (_) {
      return Left(ServerFuiler('Failed to sign in. Please try again.'));
    }
  }

  @override
  Future<Either<Fuiler, UserEntity>> register(String email, String password, String name)async {
    try {
      final result = await userDataSource.register(email, password, name);
      return Right(result);
    } on AuthApiException catch  (e) {
print("Supabase Auth Error: ${e.message}");  


    return left(ServerFuiler('Failed to create your account. Please try again.'));
    }
  }
}
