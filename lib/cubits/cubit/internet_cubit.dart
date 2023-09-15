
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';

enum InternetState {initial, lost, connected}

class InternetCubit extends Cubit<InternetState> {
  Connectivity connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetCubit() : super(InternetState.initial) {
    connectivitySubscription = connectivity.onConnectivityChanged.listen((event) {
      if(event == ConnectivityResult.mobile || event == ConnectivityResult.wifi) {
        emit(InternetState.connected);
      } else {
        emit(InternetState.lost);
      }
    });
  }

  @override
  Future<void> close(){
    connectivitySubscription?.cancel();
    return super.close();
  }
}