// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'signup_screen_imports.dart';

// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: Responsive(
//         mobile: const MobileSignupScreen(),
//         desktop: Row(
//           children: [
//             const Expanded(
//               child: SignUpScreenTopImage(),
//             ),
//             SingleChildScrollView(
//               child: Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     SizedBox(
//                       width: 450,
//                       child: SignUpForm(),
//                     ),
//                     SizedBox(height: defaultPadding / 2),
//                     // SocalSignUp()
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MobileSignupScreen extends StatelessWidget {
//   const MobileSignupScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         const SignUpScreenTopImage(),
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Row(
//                   children: const [
//                     Spacer(),
//                     Expanded(
//                       flex: 8,
//                       child: SignUpForm(),
//                     ),
//                     Spacer(),
//                   ],
//                 ),
//                 const SocalSignUp()
//               ],
//             ),
//           ),
//         ),
//         // const OrDivider(),
//       ],
//     );
//   }
// }

// import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/registration_bloc/bloc/register_bloc.dart';
import '../../../application/registration_bloc/event/register_event.dart';
import '../../../application/registration_bloc/state/register_states.dart';
import '../../constants.dart';
import '../../validation/email_verification.dart';
import '../Login/login_screen.dart';
// import 'package:onboarding/login.dart';
// import 'package:ui/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool hidePsd = true;
  bool hidePsd1 = true;
  bool agreed = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, perform form submission logic here
      String email = _emailController.text;
      String password = _passwordController.text;
      String fullName = _fullNameController.text;

      BlocProvider.of<RegisterationBloc>(context).add(StartRegistionEvent(
          fullname: fullName, username: email, password: password));
      print('full name: $fullName');
      print('Email: $email');
      print('Password: $password');
    }
  }

  @override
  void deactivate() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _confirmPasswordController.dispose();
    BlocProvider.of<RegisterationBloc>(context).add(InitialRegistionEvent());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterationBloc, RegisterStates>(
        listener: (context, st) {
      if (st is RegisterSuccessState) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => LoginScreen())));
        // showDialog<String>(
        //   barrierDismissible: false,
        //   context: context,
        //   builder: (BuildContext context) => Dialog(
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           Icon(Icons.done, color: Colors.green, size: 60),
        //           Text(
        //               "Registration Successfull, \nPlease login to your account.",
        //               textAlign: TextAlign.center,
        //               style: TextStyle(color: Colors.green, fontSize: 18)),
        //           const SizedBox(height: 15),
        //           TextButton(
        //             onPressed: () {
        //               // Navigator.pop(context);
        //               Navigator.of(context).pushReplacement(MaterialPageRoute(
        //                   builder: ((context) => LoginScreen())));
        //             },
        //             child: Container(
        //               color: Colors.blue,
        //               padding: EdgeInsets.all(5),
        //               margin: EdgeInsets.all(5),
        //               child: const Text('Login',
        //                   style: TextStyle(color: Colors.white, fontSize: 24)),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // );
      }
    }, builder: (context, registerationState) {
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
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  Image.asset(
                    "assets/AICLOGO.png",
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  Image.asset("assets/logo.png",
                      height: MediaQuery.of(context).size.height / 7),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 34.0,
                      fontWeight: FontWeight.w700,
                      height: 1.5, // line height: 57px / font size: 38px
                      letterSpacing: 0.0,
                      color: Color.fromRGBO(71, 128, 108, 1),
                      // no letter spacing
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  registerationState is RegisterFailedState
                      ? Center(
                          child: Text("Error please try again.",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20)))
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    // height: 56,
                    // width: 361,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Full name',
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                        prefixIcon: Icon(Icons.person),
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
                          return "Please enter your full name";
                        }
                      }),
                      controller: _fullNameController,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  // )))
                  Container(
                    alignment: Alignment.center,
                    // height: 56,
                    // width: 361,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                        prefixIcon: Icon(Icons.email_outlined),
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
                      validator: ((email) {
                        return Validators().isEmailValid(email);
                      }),
                      controller: _emailController,
                    ),
                  ),

                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    // height: 56,
                    // width: 361,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: "Password",
                        // Placeholder text
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
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePsd1 = !hidePsd1;
                              });
                            },
                            icon: Icon(
                              hidePsd1
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            )),
                        //  contentPadding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }

                        // Password complexity validation
                        // final hasUppercase = value.contains(RegExp(r'[A-Z]'));
                        // final hasLowercase = value.contains(RegExp(r'[a-z]'));
                        // final hasDigits = value.contains(RegExp(r'[0-9]'));
                        // final hasSpecialCharacters =
                        //     value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

                        // if (!hasUppercase) {
                        //   return 'Password must contain at least one uppercase letter';
                        // }
                        // if (!hasLowercase) {
                        //   return 'Password must contain at least one lowercase letter';
                        // }
                        // if (!hasDigits) {
                        //   return 'Password must contain at least one digit.';
                        // }
                        // if (!hasSpecialCharacters) {
                        //   return 'Password must contain at least one special characters.';
                        // }

                        return null;
                      },
                      controller: _passwordController,
                      obscureText: hidePsd1,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    alignment: Alignment.center,
                    // height: 56,
                    // width: 361,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: false,
                          hintText: 'Confirm password',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300),
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
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
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePsd = !hidePsd;
                                });
                              },
                              icon: Icon(
                                hidePsd
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ))),
                      validator: ((value) {
                        if (value != _passwordController.text) {
                          return "Password doesn't match!";
                        }
                        return null;
                      }),
                      controller: _confirmPasswordController,
                      obscureText: hidePsd,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Checkbox(
                        value: agreed,
                        onChanged: (value) {
                          setState(() {
                            agreed = !agreed;
                          });
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              agreed = !agreed;
                            });
                          },
                          child: Text(
                            "I Agree to",
                            style: const TextStyle(color: kPrimaryColor),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        text: 'Hello ',
                                        children: const <TextSpan>[
                                          TextSpan(
                                              text: 'bold',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(text: ' world!'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            " terms and conditions",
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),

                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 56,
                    width: 361,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(239, 188, 8, 1),
                      ),
                      onPressed: agreed
                          ? registerationState is RegisterLoadingState
                              ? null
                              : _submitForm
                          : null,
                      child: registerationState is RegisterLoadingState
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
                    margin: EdgeInsets.symmetric(horizontal: 48),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Already have an account?",
                        ),
                        InkWell(
                            onTap: registerationState is RegisterLoadingState
                                ? null
                                : () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    );
                                  },
                            child: Text(" Sign in",
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
