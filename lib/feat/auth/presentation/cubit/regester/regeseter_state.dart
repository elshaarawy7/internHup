import 'package:intern_hup/core/error/fuiler.dart';
import 'package:intern_hup/feat/auth/domain/entity/user_entity.dart';

abstract class RegeseterState{
  
}

class RegeseterInitial extends RegeseterState{} 

class RegeseterLoading extends RegeseterState{} 

class RegeseterSuccess extends RegeseterState{
  final UserEntity userEntity ; 

  RegeseterSuccess(this.userEntity); 
} 
class RegeseterFailure extends RegeseterState{
  final Fuiler fuiler ; 

  RegeseterFailure(this.fuiler); 
  
} 


  
