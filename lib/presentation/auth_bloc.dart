import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/domain/repositories/user_repository.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserEntity user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.login(email, password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError('Login failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.register(email, password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError('Registration failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(AuthInitial());
  }

  Future<void> forgotPass(String email) async {
    try {
      emit(AuthLoading());
      await _authRepository.forgotPassword(email);
      emit(
          AuthInitial()); // You can also create a state like AuthEmailSent if needed
    } catch (e) {
      emit(AuthError(e
          .toString())); // This will now get the detailed message from the repository
    }
  }

  Future<void> checkCurrentUser() async {
    final user = await _authRepository.getCurrentUser();
    if (user != null) {
      emit(Authenticated(user));
    }
  }
}
