import 'package:intern_hup/feat/auth/data/models/user_model.dart';

abstract class UserDataSource {

  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
  Future<UserModel> SinginWihtGoogle();
}
  