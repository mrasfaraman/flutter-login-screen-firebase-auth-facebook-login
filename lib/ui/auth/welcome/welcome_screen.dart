import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_screen/constants.dart';
import 'package:flutter_login_screen/services/helper.dart';
import 'package:flutter_login_screen/ui/auth/login/login_screen.dart';
import 'package:flutter_login_screen/ui/auth/signUp/sign_up_screen.dart';
import 'package:flutter_login_screen/ui/auth/welcome/welcome_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WelcomeBloc>(
      create: (context) => WelcomeBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocListener<WelcomeBloc, WelcomeInitial>(
              listener: (context, state) {
                switch (state.pressTarget) {
                  case WelcomePressTarget.login:
                    push(context, const LoginScreen());
                    break;
                  case WelcomePressTarget.signup:
                    push(context, const SignUpScreen());
                    break;
                  default:
                    break;
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: ClipRRect(
        borderRadius: BorderRadius.circular(75.0), // Half of width or height to make it circular
        child: Image.network(
          'https://www.shutterstock.com/image-vector/happy-cute-school-boy-writing-600nw-631729163.jpg',
          width: 170.0,
          height: 170.0,
          fit: BoxFit.cover,
        ),
      ),

                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 16, top: 32, right: 16, bottom: 8),
                    child: Text(
                      'Kids Job Application App',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(colorPrimary),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  //   child: Text(
                  //     'You\'ve just saved a week of development and headaches.',
                  //     style: TextStyle(fontSize: 18),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromWidth(
                            MediaQuery.of(context).size.width / 1.5),
                        backgroundColor: const Color(colorPrimary),
                        textStyle: const TextStyle(color: Colors.white),
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: const BorderSide(color: Color.fromARGB(255, 255, 255, 255))),
                      ),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onPressed: () {
                        context.read<WelcomeBloc>().add(LoginPressed());
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 40.0, left: 40.0, top: 20, bottom: 20),
                    child: TextButton(
                      onPressed: () {
                        context.read<WelcomeBloc>().add(SignupPressed());
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        fixedSize: Size.fromWidth(
                            MediaQuery.of(context).size.width / 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: const BorderSide(
                            color: Color(colorPrimary),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(colorPrimary)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
