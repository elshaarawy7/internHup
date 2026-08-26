import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_hup/feat/auth/data/repo/auth_repo.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/regester/regeseter_state.dart';

class RegeseterCubit extends Cubit<RegeseterState>{
  final AuthRepo authRepo ; 
  RegeseterCubit(this.authRepo) : super(RegeseterInitial());
  

  static get(context)=> BlocProvider.of<RegeseterCubit>(context) ;   

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>(); 


  Future<void> regeseter()async{
    
    if(formKey.currentState!.validate()){ 

      emit(RegeseterLoading()) ; 

      await authRepo.register(
        emailController.text,
        passwordController.text,
        nameController.text,
      ).then((value) {
        value.fold((failure) {
          emit(RegeseterFailure(failure)); 
        }, (user) {
          emit(RegeseterSuccess(user)); 
        }); 
      }) ;
      
    }
    


  }


  
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    return super.close();
  }
}
