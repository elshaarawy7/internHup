/// Login cubit.
///
/// Will manage authentication state for the Login screen.
/// Implement when Supabase authentication is integrated and
/// `flutter_bloc` is added as a dependency.
///
/// Future architecture:
///   LoginPage
///       ↓
///   LoginCubit  (this file)
///       ↓
///   LoginUseCase
///       ↓
///   AuthRepository
///       ↓
///   AuthDataSource
///       ↓
///   Supabase

// TODO: Implement LoginCubit.
// Example:
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'login_state.dart';
//
// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(const LoginInitial());
//
//   Future<void> login({
//     required String email,
//     required String password,
//   }) async {
//     emit(const LoginLoading());
//     try {
//       // await authRepository.login(email: email, password: password);
//       emit(const LoginSuccess());
//     } catch (e) {
//       emit(LoginFailure(e.toString()));
//     }
//   }
//
//   Future<void> loginWithGoogle() async {
//     emit(const LoginLoading());
//     try {
//       // await authRepository.loginWithGoogle();
//       emit(const LoginSuccess());
//     } catch (e) {
//       emit(LoginFailure(e.toString()));
//     }
//   }
// }
