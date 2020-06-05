import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPress extends LoginEvent {
  final String userName;
  final String password;

  const LoginButtonPress(this.userName, this.password);

  @override
  List<Object> get props => [userName, password];

  @override
  String toString() => 'LoginButtonPressed { username: $userName, password: $password }';
}