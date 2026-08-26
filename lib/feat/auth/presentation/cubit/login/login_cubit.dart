import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_hup/feat/auth/data/repo/auth_repo.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final AuthRepo authRepo;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());

      final result = await authRepo.login(
        emailController.text,
        passwordController.text,
      );

      result.fold(
        (failure) => emit(LoginFailure(failure)),
        (user) => emit(LoginSuccess(user)),
      );
    }
  }
}
