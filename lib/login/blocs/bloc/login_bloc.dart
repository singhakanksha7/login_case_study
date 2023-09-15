

import 'package:bloc/bloc.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginTextChangedEvent>((event, emit) {
      if(event.emailValue.isEmpty && event.passwordValue.isEmpty){
        emit(LoginFailureState("Please enter valid credentials"));
      }
      else if(event.passwordValue.isEmpty) {
        emit(LoginFailureState("Please enter valid credentials"));
      }
      else if(event.emailValue == "Axis" && event.passwordValue == "Flutter@123"){ 
        emit(LoginValidState());
      }
    });
    on<LoginButtonPressedEvent >((event, emit) {
      if(event.emailValue == "Axis" && event.passwordValue == "Flutter@123") {
      emit(LoginValidState() );
      }
    });
  }
}
