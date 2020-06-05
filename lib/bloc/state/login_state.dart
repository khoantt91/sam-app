import 'package:equatable/equatable.dart';
import 'package:samapp/model/user.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginErrorUserName extends LoginState {
  final String error;

  const LoginErrorUserName(this.error);
}

class LoginErrorPassword extends LoginState {
  final String error;

  const LoginErrorPassword(this.error);
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginSuccess extends LoginState {
  final User user;

  const LoginSuccess(this.user);
}
