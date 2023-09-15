import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_case_study/cubits/cubit/internet_cubit.dart';

// ignore: must_be_immutable
class DashboardPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var name;
  DashboardPage(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intro Page'),
      ),
      body: BlocProvider(
        create: (context) => InternetCubit(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: BlocBuilder<InternetCubit, InternetState>(
                    builder: (context, state) {
                      if(state == InternetState.lost) {
                        return Text('Welcome $name, You are not connected to internet',
                          style: const TextStyle(fontSize: 20));
                      }
                      else if(state == InternetState.initial) {
                        return Text('Welcome $name, Your account is loading....',
                          style: const TextStyle(fontSize: 20));
                      }
                      else {
                        return Text('Welcome $name',
                          style: const TextStyle(fontSize: 20));
                      }
                      
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
