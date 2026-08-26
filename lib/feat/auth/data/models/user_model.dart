import 'package:intern_hup/feat/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.email, required super.name, required super.role}); 

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      role: map['role'],
    );
  }
}