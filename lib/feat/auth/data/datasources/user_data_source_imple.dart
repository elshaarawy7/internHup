import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intern_hup/core/constant/app_constant.dart';
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

  @override
  Future<UserModel> SinginWihtGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize(
        serverClientId: AppConstant.supabaseGoogleId,
      );

      final googleUser = await googleSignIn.authenticate();

      // الحصول على access token عبر scopes الصحيحة (إيميل + بروفايل)
      // هذا الـ scopes هو المطلوب من Supabase للتحقق من المستخدم
      final authorization =
          await googleUser.authorizationClient.authorizationForScopes(
        const ['email', 'profile'],
      ) ??
          await googleUser.authorizationClient.authorizeScopes(
        const ['email', 'profile'],
          );

      // idToken يُستخدم للتحقق عند Supabase
      final idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        throw Exception(
          'No ID Token found. Please verify the Google OAuth client ID and SHA-1 configuration in Google Cloud Console.',
        );
      }

      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );

      if (response.user == null) {
        throw Exception('Sign in succeeded but the user object is null.');
      }

      return UserModel.fromMap(response.user!.toJson());
    } catch (e, st) {
      debugPrint('❌ Google Login Error: $e');
      debugPrint('StackTrace: $st');
      rethrow;
    }
  }



  
}
