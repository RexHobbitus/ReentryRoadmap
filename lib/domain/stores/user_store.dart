import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';

class UserStore extends Cubit<LoginUser>{
  /// for temporary set this variable True or False for Login or Logout state
  UserStore():super(LoginUser.empty());
  setUser(LoginUser loginUser){
    emit(loginUser);
  }

}