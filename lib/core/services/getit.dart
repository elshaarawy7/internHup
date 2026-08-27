 

import 'package:get_it/get_it.dart';
import 'package:intern_hup/core/services/subabase_server.dart';
import 'package:intern_hup/feat/auth/data/datasources/user_data_source_imple.dart';
import 'package:intern_hup/feat/auth/data/datasources/user_datasource.dart';
import 'package:intern_hup/feat/auth/data/repo/auth_repo.dart';
import 'package:intern_hup/feat/auth/data/repo/uath_repo_imple.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/login/login_cubit.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/google/google_cubit.dart';
import 'package:intern_hup/feat/auth/presentation/cubit/regester/regester_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt getIt = GetIt.instance; 

void setupGetIt() {
  getIt.registerLazySingleton<UserDataSource>(
    () => UserDataSourceImpl(Supabase.instance.client),
  );
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<UserDataSource>()),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<AuthRepo>()),
  );
  getIt.registerFactory<GogooleCubit>(
    () => GogooleCubit(getIt<AuthRepo>()),
  );
  getIt.registerFactory<RegeseterCubit>(
    () => RegeseterCubit(getIt<AuthRepo>()),
  );
}
