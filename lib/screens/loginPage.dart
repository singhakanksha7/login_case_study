import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_case_study/login/blocs/bloc/login_bloc.dart';
import 'package:login_case_study/screens/dashboardPage.dart';
import 'package:login_case_study/utils/extensions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  static const String title = 'Wallpapers';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(title),
        ),
        body: buildInitialInput());
  }

  Widget buildInitialInput() => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10, bottom: 0),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                )),
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 0, bottom: 10),
                child: const Text(
                  'Please login to  your account',
                  style: TextStyle(fontSize: 15),
                )),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10, bottom: 0),
              child: TextField(
                controller: emailController,
                onChanged: (value) {
                  BlocProvider.of<LoginBloc>(context).add(LoginTextChangedEvent(
                      emailController.text, passwordController.text));
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                onChanged: (value) {
                  BlocProvider.of<LoginBloc>(context).add(LoginTextChangedEvent(
                      emailController.text, passwordController.text));
                },
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return SizedBox(
                  height: 65,
                  width: 360,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        if(emailController.text.isValidEmail()) {
                          BlocProvider.of<LoginBloc>(context).add(LoginButtonPressedEvent(
                      emailController.text, passwordController.text));
                        if (state is LoginFailureState) {
                          buildErrorLayout(state.errorMessage);
                        } else if(state is LoginValidState) {
                          loginSuccess(emailController.text);
                        }
                        }
                        else {
                          buildErrorLayout("Enter valid credentials");
                        }
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 65,
              child: Center(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 62),
                      child: Text('Do not have account? '),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: InkWell(
                          onTap: () {
                            // print('hello');
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 14, color: Colors.blue),
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );

  buildErrorLayout(errorMessage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Try Again!!'),
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok"))
              ],
            ));
  }

  loginSuccess(loginName) {
    clearTextData();
    // Beamer.of(context).beamToNamed('/screens/dashboard');
    Navigator.push(
       context, 
      MaterialPageRoute(builder: (context) => DashboardPage(loginName),
    ));
    
    // showDialog(
    //     context: context,
    //     builder: (ctx) => AlertDialog(
    //           title: const Text('Login!!'),
    //           content: const Text('Login Successful!'),
    //           actions: <Widget>[
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                 },
    //                 child: const Text("Ok"))
    //           ],
    //         ));
  }

  clearTextData() {
    emailController.clear();
    passwordController.clear();
  }
}
