import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/auth_bloc/bloc/check_auth_bloc.dart';
import '../../../application/auth_bloc/bloc/signOut_bloc.dart';
import '../../../application/auth_bloc/event/sign_out_events.dart';
import '../../../application/auth_bloc/state/check_auth_state.dart';
import '../../../application/theme_bloc/bloc/theme_bloc.dart';
import '../../../application/theme_bloc/event/theme_event.dart';
import '../../../application/theme_bloc/state/theme_state.dart';
import '../../components/terms_and_conditions.dart';
import '../../constants.dart';
import '../About/about.dart';
import '../Feedback/feedback.dart';
import '../Change Password/change_password.dart';
import 'package:share_plus/share_plus.dart';

import '../Welcome/welcome_screen.dart';
import 'components/thankyou_popup.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (contexts, _) {
      return BlocBuilder<CheckAuthBloc, CheckAuthStates>(
          builder: (contexts, checkAuthst) {
        if (checkAuthst is CheckAuthSuccessState)
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              centerTitle: true,
              leading: null,
              title: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color:
                        BlocProvider.of<ThemeBloc>(context).state.blackColor),
              ),
            ),
            body: Container(
              padding: EdgeInsets.only(left: 16, top: 1, right: 16),
              child: ListView(
                children: [
                  // Center(
                  //   child: Text(
                  //     "Settings",
                  //     style: TextStyle(
                  //         fontSize: 25,
                  //         fontWeight: FontWeight.w500,
                  //         color: BlocProvider.of<ThemeBloc>(context)
                  //             .state
                  //             .blackColor),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: kPrimaryColor,
                            child: Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                checkAuthst.name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: BlocProvider.of<ThemeBloc>(context)
                                        .state
                                        .blackColor),
                              ),
                              Text(
                                checkAuthst.email,
                                style: TextStyle(
                                  color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .blackColor,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<ThemeBloc>(context)
                              .add(ChangeThemeEvent());
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: BlocProvider.of<ThemeBloc>(context).state
                                  is DarkThemeState
                              ? Icon(Icons.light_mode,
                                  color: kPrimaryColor, size: 40)
                              : Icon(Icons.dark_mode,
                                  color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .blackColor,
                                  size: 40),
                        ),
                      )
                      // Icon(Icons.chevron_right_rounded,
                      //     size: 40, color: kPrimaryColor)
                    ],
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: buildAccountOptionRow(
                  //       context, "Change password", Icons.lock_outline_rounded),
                  // ),
                  // buildNotificationOptionRow("Dark Mode", true),
                  SizedBox(
                    height: 25,
                  ),
                  Text("Account Settings",
                      style: TextStyle(
                          fontSize: 20,
                          color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .blackColor ==
                                  Colors.white
                              ? const Color.fromARGB(255, 197, 196, 196)
                              : BlocProvider.of<ThemeBloc>(context)
                                  .state
                                  .blackColor)),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color:
                        BlocProvider.of<ThemeBloc>(context).state.blackColor ==
                                Colors.white
                            ? greyColor[600]
                            : greyColor[300],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  buildAccountOptionRow(
                      context, "Change password", Icons.lock_outline_rounded,
                      () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ResetPassword()));
                  }),
                  buildAccountOptionRow(context, "Sign Out", Icons.logout, () {
                    BlocProvider.of<SignOutBloc>(context)
                        .add(StartSignOutEvent());
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()),
                        (route) => false);
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  Text("More Settings",
                      style: TextStyle(
                          fontSize: 20,
                          color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .blackColor ==
                                  Colors.white
                              ? const Color.fromARGB(255, 197, 196, 196)
                              : BlocProvider.of<ThemeBloc>(context)
                                  .state
                                  .blackColor)),
                  Divider(
                    height: 10,
                    thickness: 2,
                    color:
                        BlocProvider.of<ThemeBloc>(context).state.blackColor ==
                                Colors.white
                            ? greyColor[600]
                            : greyColor[300],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  buildAccountOptionRow(
                      context,
                      "Give Us Feedback",
                      Icons.feedback_outlined,
                      //     () {
                      //   Navigator.of(context)
                      //       .push(MaterialPageRoute(builder: (context) => FeedBack()));
                      // }),
                      showFeedbackDialog(context)),
                  buildAccountOptionRow(
                      context, "About Us", Icons.info_outline_rounded, () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => About()));
                  }),
                  buildAccountOptionRow(
                      context, "Terms And Conditions", Icons.list_alt_sharp,
                      () {
                    TermsAndConditions(context);
                  }),
                  buildAccountOptionRow(
                      context, "Rate App", Icons.rate_review_outlined, () {
                    _openAppStore();
                  }),
                  buildAccountOptionRow(context, "Share the app", Icons.share,
                      () async {
                    ShareResult result = await Share.shareWithResult(
                        'Check out this awesome app! Download it now: https://your-app-url.com');
                    if (result.raw.isNotEmpty) {
                      showThankYouDialog(context);
                    }
                  }),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Center(
                  //   child: OutlinedButton.icon(
                  //     // padding: EdgeInsets.symmetric(horizontal: 40),
                  //     style: ButtonStyle(
                  //       side: MaterialStateBorderSide.resolveWith(
                  //           (states) => BorderSide(
                  //                 color: Colors.red,
                  //               )),
                  //       backgroundColor: MaterialStateColor.resolveWith(
                  //           (states) => Colors.transparent),
                  //     ),
                  //     onPressed: () {},
                  //     icon: Padding(
                  //       padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 8),
                  //       child: Icon(Icons.logout_outlined, color: Colors.red),
                  //     ),
                  //     label: Text(
                  //       "SIGN OUT",
                  //       style: TextStyle(
                  //           fontSize: 16, letterSpacing: 2.2, color: Colors.red),
                  //     ),
                  //   ),
                  // ),

                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          );
        else {
          return Container(
              child: Center(
                  child: Text(
                      "please re install the application, report if this problem persists.")));
        }
      });
    });
  }

  buildNotificationOptionRow(String title, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: BlocProvider.of<ThemeBloc>(context).state.blackColor),
          ),
          Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                value: isActive,
                onChanged: (bool val) {},
              ))
        ],
      ),
    );
  }

  void _openAppStore() async {
    if (Platform.isAndroid || true) {
      final url = Uri(
          scheme: 'https',
          host: 'play.google.com',
          path: 'store/apps/details',
          queryParameters: {"id": "your.app.package"});
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
      // } else if (Platform.isIOS) {
    } else {
      final url = Uri(
        scheme: 'https',
        host: 'itunes.apple.com',
        path: 'app/your-app-name/idyourappid',
      );
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  showFeedbackDialog(context) => () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return FeedBack();
            });
      };
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => FeedBack(),
  //   ));
  // };
  GestureDetector buildAccountOptionRow(
      BuildContext context, String title, IconData icon, Function()? ontap) {
    return GestureDetector(
      onTap: ontap,

      child: ListTile(
        // trailing: Icon(
        //   Icons.arrow_forward_ios,
        //   color: Colors.grey,
        // ),
        leading: Icon(icon, color: kPrimaryColor),
        title:
            //  Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [ 
            // Icon(icon, color: kPrimaryColor),
            // SizedBox(width: 5),
            Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: BlocProvider.of<ThemeBloc>(context).state.blackColor ==
                      Colors.white
                  ? const Color.fromARGB(255, 197, 196, 196)
                  : BlocProvider.of<ThemeBloc>(context).state.blackColor),
          // style: GoogleFonts.oswald(
          //   fontSize: 20,
          //   fontWeight: FontWeight.w500,
          // ),
          //   ),
          // ],
        ),
        // Icon(
        //   Icons.arrow_forward_ios,
        //   color: Colors.grey,
        // ),
        // ],
      ),
      // ),
    );
  }
}
