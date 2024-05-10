

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  

  LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String lname;
  

  RegisterEvent(this.email, this.password,this.name,this.lname);
}