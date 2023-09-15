part of 'login_bloc.dart';

abstract class LoginState {
}

class LoginInitial extends LoginState {}
class LoginValidState extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginFailureState extends LoginState {
  final String errorMessage;
  LoginFailureState(this.errorMessage); 

}