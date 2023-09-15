part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginTextChangedEvent extends LoginEvent {
  final String emailValue;
  final String passwordValue;
  LoginTextChangedEvent(this.emailValue, this.passwordValue);
}

class LoginButtonPressedEvent extends LoginEvent {
    final String emailValue;
    final String passwordValue;
  LoginButtonPressedEvent(this.emailValue, this.passwordValue);
}