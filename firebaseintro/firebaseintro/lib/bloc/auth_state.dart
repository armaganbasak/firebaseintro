import 'package:firebaseintro/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel usermodel;
  AuthSuccess({required this.usermodel});
}

class AuthError extends AuthState {
  final String? errorMessage;

  AuthError({this.errorMessage});
}