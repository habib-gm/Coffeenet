// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'LoginScreen_screen_imports.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: SingleChildScrollView(
//         child: Responsive(
//           mobile: const MobileLoginScreen(),
//           desktop: Row(
//             children: [
//               const Expanded(
//                 child: LoginScreenTopImage(),
//               ),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     SizedBox(
//                       width: 450,
//                       child: LoginForm(),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MobileLoginScreen extends StatelessWidget {
//   const MobileLoginScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         const LoginScreenTopImage(),
//         Row(
//           children: const [
//             Spacer(),
//             Expanded(
//               flex: 8,
//               child: LoginForm(),
//             ),
//             Spacer(),
//           ],
//         ),
//         // const SocalSignUp()
//       ],
//     );
//   }
// }

import 'package:coffee_net/application/auth_bloc/bloc/check_auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth_bloc/bloc/auth_bloc.dart';
import '../../../application/auth_bloc/event/auth_events.dart';
import '../../../application/auth_bloc/event/check_auth_event.dart';
import '../../../application/auth_bloc/state/auth_states.dart';
import '../../constants.dart';
import '../Landings/main_screen.dart';
import '../Signup/signup_screen.dart';
// import 'package:onboarding/signup.dart';
// import 'package:ui/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool hidePsd = true;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, perform form submission logic here
      String email = _emailController.text;
      String password = _passwordController.text;
      BlocProvider.of<AuthBloc>(context).add(LoginEvent(email, password));
      print('Email: $email');
      print('Password: $password');
    }
  }

  @override
  void deactivate() {
    _emailController.dispose();
    _passwordController.dispose();
    BlocProvider.of<AuthBloc>(context).add(InitialEvent());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthStates>(listener: (context, state) {
      if (state is LoggedInState) {
        BlocProvider.of<CheckAuthBloc>(context).add(CheckAuthEvent());
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false);
      }

      // if (state is LoginFailedState) {
      //   showDialog<String>(
      //     context: context,
      //     builder: (BuildContext context) => Dialog(
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: <Widget>[
      //             const Icon(Icons.error, color: Colors.red, size: 60),
      //             const Text("Error, Please try again!",
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(color: Colors.red, fontSize: 18)),
      //             const SizedBox(height: 15),
      //             TextButton(
      //               onPressed: () {
      //                 Navigator.pop(context);
      //               },
      //               child: Container(
      //                 color: Colors.blue,
      //                 padding: const EdgeInsets.all(5),
      //                 margin: const EdgeInsets.all(5),
      //                 child: const Text('Retry',
      //                     style: TextStyle(color: Colors.white, fontSize: 24)),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   );
      // }
    }, builder: (context, authState) {
      return Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Image.asset("assets/AICLOGO.png",
                      height: MediaQuery.of(context).size.height / 6),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Image.asset("assets/logo.png"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Text(
                    "SIGN IN",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 38.0,
                      fontWeight: FontWeight.w700,
                      height: 1.5, // line height: 57px / font size: 38px
                      letterSpacing: 0.0,
                      color: Color.fromRGBO(71, 128, 108, 1),
                      // no letter spacing
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  authState is LoginFailedState
                      ? Center(
                          child: Text("Error please try again.",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20)))
                      : Container(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    alignment: Alignment.center,
                    // height: 54,
                    // width: 361,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(239, 188, 8, 1))),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(239, 188, 8, 0.6)),
                          // Color of the border when focused
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(239, 188, 8, 1))),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.5,
                              color: Color.fromRGBO(239, 188, 8, 1)),
                        ),
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );

                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                      }),
                      controller: _emailController,
                    ),
                  ),

                  SizedBox(
                    height: 28,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    // height: 54,
                    // width: 361,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: "Password",
                        // Placeholder text
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePsd = !hidePsd;
                              });
                            },
                            icon: Icon(
                              hidePsd ? Icons.visibility_off : Icons.visibility,
                            )),
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(239, 188, 8, 1))),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(239, 188, 8, 0.6)),
                          // Color of the border when focused
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(239, 188, 8, 1))),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.5,
                              color: Color.fromRGBO(239, 188, 8, 1)),
                        ),

                        focusColor: Color.fromRGBO(239, 188, 8, 1),
                        //  contentPadding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: hidePsd,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 45),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Text(
                  //         "Forget Password?",
                  //         style: TextStyle(),
                  //       ),
                  //       InkWell(
                  //           onTap: () {},
                  //           child: Text(" Reset now!",
                  //               style: TextStyle(
                  //                   color: Color.fromRGBO(71, 128, 108, 1)))),
                  //     ],
                  //   ),
                  // ),

                  // SizedBox(
                  //   height: 38,
                  // ),
                  Container(
                    height: 56,
                    width: 361,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(239, 188, 8, 1),
                        disabledBackgroundColor: Colors.grey.shade300,
                      ),
                      onPressed:
                          authState is LoggingInState ? null : _submitForm,
                      child: authState is LoggingInState
                          ? CircularProgressIndicator(color: kPrimaryColor)
                          : Text('Submit',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                height:
                                    1.5, // line height: 24px / font size: 16px
                                letterSpacing: 0.13,
                              )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(),
                        ),
                        InkWell(
                            onTap: authState is LoggingInState
                                ? null
                                : () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()),
                                    );
                                  },
                            child: Text(" Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(71, 128, 108, 1)))),
                      ],
                    ),
                  ),
                  // Container(child: TextField())
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
