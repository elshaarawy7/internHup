import 'package:dartz/dartz.dart';
import 'package:intern_hup/core/error/fuiler.dart';
import 'package:intern_hup/feat/auth/domain/entity/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Fuiler, UserEntity>> login(String email, String password);
  Future<Either<Fuiler, UserEntity>> register(String email, String password , String name );
   Future<Either<Fuiler, UserEntity>> signWithGoogle(); 
}