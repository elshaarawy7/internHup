import 'package:intern_hup/feat/auth/data/datasources/user_datasource.dart';
import 'package:intern_hup/feat/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDataSourceImpl implements UserDataSource {
  final SupabaseClient supabase;

  UserDataSourceImpl(this.supabase);

  @override
  Future<UserModel> login(String email, String password)async {
     
    final response = await supabase.auth.signInWithPassword(email: email, password: password); 
     
     final user = response.user;
     if(user!=null){
      
      return UserModel.fromMap(user.toJson());
     }

     throw Exception('failed to sign in '); 
  }

  @override
  Future<UserModel> register(String email, String password, String name)async {
    
     final response = await supabase.auth.signUp(
       email: email,
       password: password,
       data: {'full_name': name},
     );
     final user = response.user;
     if(user!=null){
      
      return UserModel.fromMap(user.toJson());
     }

     throw Exception('failed to sign up '); 
  } 

  
}
