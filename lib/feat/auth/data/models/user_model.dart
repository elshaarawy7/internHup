import 'package:intern_hup/feat/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.email, required super.name, required super.role}); 

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final metadata = Map<String, dynamic>.from(
      map['user_metadata'] as Map? ?? const {},
    );

    return UserModel(
      id: map['id'] as String? ?? '',
      email: map['email'] as String? ?? '',
      name: map['name'] as String? ??
          metadata['name'] as String? ??
          metadata['full_name'] as String? ??
          '',
      role: map['role'] as String? ?? metadata['role'] as String? ?? '',
    );
  }
}
