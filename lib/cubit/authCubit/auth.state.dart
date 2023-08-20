import 'package:todo_frontend/models/user.model.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class AuthDone extends AuthState {
  User user;
  AuthDone(this.user);
}

class AuthError extends AuthState {
  String err;
  AuthError(this.err);
}

class AuthLoading extends AuthState {}
