import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../application/auth_bloc/bloc/signOut_bloc.dart';
import '../application/auth_bloc/event/sign_out_events.dart';
import '../application/theme_bloc/bloc/theme_bloc.dart';
import '../application/theme_bloc/event/theme_event.dart';
import '../presentation/constants.dart';
import '../presentation/pages/Welcome/welcome_screen.dart';

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Alert!!"),
        content: Text("You are awesome!"),
        actions: [
          MaterialButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

popupMenu(BuildContext context, String name) => PopupMenuButton<int>(
    padding: const EdgeInsets.all(0.0),
    itemBuilder: (context) => [
          // PopupMenuItem 1
          PopupMenuItem(
            enabled: false,
            child: Center(
              child: Text(name,
                  style: TextStyle(
                      color: BlocProvider.of<ThemeBloc>(context)
                          .state
                          .blackColor)),
            ),
          ),
          PopupMenuItem(
            value: 1,
            // row with 2 children
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, color: Colors.red),
                SizedBox(
                  width: 5,
                ),
                Text("Sign out", style: TextStyle(color: Colors.red))
              ],
            ),
          ),
          // // PopupMenuItem 2
          // PopupMenuItem(
          //   value: 2,
          //   // row with two children
          //   child: Row(
          //     children: [
          //       Icon(Icons.chrome_reader_mode),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Text(
          //         "About",
          //         style: TextStyle(
          //             color:
          //                 BlocProvider.of<ThemeBloc>(context).state.blackColor),
          //       )
          //     ],
          //   ),
          // ),
        ],
    // offset: Offset(0, 100),
    color: BlocProvider.of<ThemeBloc>(context).state.whiteColor,
    elevation: 2,
    // on selected we show the dialog box
    onSelected: (value) {
      // if value 1 show dialog
      if (value == 1) {
        BlocProvider.of<SignOutBloc>(context).add(StartSignOutEvent());
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (route) => false);
      }
    },
    splashRadius: 20,
    icon:
        // Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: Icon(
        //     BlocProvider.of<ThemeBloc>(context).state is DarkThemeState
        //         ? Icons.light_mode
        //         : Icons.dark_mode,
        //     color: BlocProvider.of<ThemeBloc>(context).state.blackColor,
        //   ),
        // )
        Center(
      child: Center(
        child: CircleAvatar(
            backgroundColor: kPrimaryColor,
            child: Icon(Icons.person_outline_rounded, color: Colors.white)),
      ),
    ));

AppBar getAppBar(BuildContext context, String name) {
  return AppBar(
    toolbarHeight: 60,
    backgroundColor: BlocProvider.of<ThemeBloc>(context).state.whiteColor,
    elevation: 1,
    leading: const Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Center(child: Image(image: AssetImage('assets/leaflogo.png'))),
    ),
    // title: const Text(
    //   "Arebica Armour",
    //   style: TextStyle(
    //     color: Color.fromRGBO(1, 155, 113, 1),
    //     fontFamily: 'times new roman',
    //     letterSpacing: 1,
    //     fontSize: 27,
    //   ),
    // ),
    title: ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [
            Color.fromARGB(188, 22, 202, 139),
            kPrimaryColor
          ], // Define your gradient colors here
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: Text(
        'COFFEENET',
        // style: TextStyle(
        //   fontSize: 24,
        //   fontWeight: FontWeight.bold,
        //   color: Colors.white,
        // ),
        style: GoogleFonts.fuzzyBubbles(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    actions: [
      // Padding(
      //   padding: EdgeInsets.all(8.0),
      //   child: Icon(
      //     Icons.settings_outlined,
      //     color: blackColor,
      //   ),
      // )
      Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: popupMenu(context, name))

      // InkWell(
      //   onTap: () {
      //     BlocProvider.of<ThemeBloc>(context).add(ChangeThemeEvent());
      //   },
      //   child: Padding(
      //     padding: EdgeInsets.all(8.0),
      //     child: Icon(
      //       BlocProvider.of<ThemeBloc>(context).state is DarkThemeState
      //           ? Icons.light_mode
      //           : Icons.dark_mode,
      //       color: BlocProvider.of<ThemeBloc>(context).state.blackColor,
      //     ),
      //   ),
      // )
      // Center(
      //   child: Padding(
      //     padding: const EdgeInsets.only(right: 10.0),
      //     child: Center(
      //       child: CircleAvatar(
      //           backgroundColor: kPrimaryColor,
      //           child: Icon(Icons.person_outline_rounded, color: Colors.white)),
      //     ),
      //   ),
      // )
    ],
  );
}
