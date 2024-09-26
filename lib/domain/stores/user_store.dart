import 'package:flutter_bloc/flutter_bloc.dart';

class UserStore extends Cubit<bool>{
  /// for temporary set this variable True or False for Login or Logout state
  UserStore():super(false);
}