import 'package:reentry_roadmap/domain/entities/app_user.dart';

abstract class AuthenticationRepository{
  Future<AppUser> loginWithEmailAndPassword({required String email,required String password});
  Future<AppUser> createAccount({required String email,required String password});
  Future<bool> forgetPassword({required String email});
  Future<bool> logout({required String email});

}