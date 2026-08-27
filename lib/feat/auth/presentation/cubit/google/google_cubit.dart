import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_hup/feat/auth/data/repo/auth_repo.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/google/google_state.dart';

class GogooleCubit extends Cubit<GogooleState> {
  GogooleCubit(this.authRepo) : super(GogooleInitial());
  final AuthRepo authRepo;

  static GogooleCubit get(context) {
    return BlocProvider.of<GogooleCubit>(context);
  }

  void loginWithGogoole() async {
    emit(GogooleLoading());
    try {
      final result = await authRepo.signWithGoogle();
      result.fold(
        (failure) => emit(GogooleFailure(failure.message)),
        (user) => emit(GogooleSuccess()),
      );
    } catch (e) {
      // safety net: في حال رُمي استثناء من طبقة الـ repo بشكل غير متوقع
      emit(GogooleFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
