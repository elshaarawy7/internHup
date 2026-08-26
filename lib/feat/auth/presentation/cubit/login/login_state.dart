import 'package:intern_hup/core/error/fuiler.dart';
import 'package:intern_hup/feat/auth/domain/entity/user_entity.dart';

abstract class LoginState{
  
}

class LoginInitial extends LoginState{} 

class LoginLoading extends LoginState{} 

class LoginSuccess extends LoginState{
  final UserEntity userEntity ; 

  LoginSuccess(this.userEntity); 
} 
class LoginFailure extends LoginState{
  final Fuiler fuiler ; 

  LoginFailure(this.fuiler); 
  
} 


  
