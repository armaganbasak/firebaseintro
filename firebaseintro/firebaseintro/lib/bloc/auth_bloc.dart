import 'package:firebaseintro/bloc/auth_event.dart';
import 'package:firebaseintro/bloc/auth_state.dart';
import 'package:firebaseintro/models/user_model.dart';
import 'package:firebaseintro/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _auth;

  AuthBloc(this._auth) : super(AuthInitial()) {
    on<LoginEvent>(_loginUser);
    on<RegisterEvent>(_registerUser);
  }

  void _loginUser(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _auth.loginUser(event.email, event.password);
      emit(AuthSuccess(usermodel: UserModel(email: event.email, pass: event.password))); 
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  void _registerUser(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _auth.registerUser(event.email, event.password, event.name, event.lname);
      emit(AuthSuccess(usermodel: UserModel(email: event.email,pass: event.password, name: event.name, lname: event.lname))); 
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }
  
}
