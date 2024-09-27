import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/domain/entities/app_user.dart';

class UserStore extends Cubit<AppUser>{
  /// for temporary set this variable True or False for Login or Logout state
  UserStore():super(AppUser.empty());

  setUser(AppUser appUser){
    emit(appUser);
  }

}