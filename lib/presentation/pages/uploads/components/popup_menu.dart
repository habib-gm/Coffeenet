import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../infrustructure/auth/repository/auth_repo_imports.dart';
import 'package:flutter/material.dart';

import '../../../../application/theme_bloc/bloc/theme_bloc.dart';
import '../../../../application/theme_bloc/event/theme_event.dart';
import '../../../../application/theme_bloc/state/theme_state.dart';
import '../../../constants.dart';

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

popupMenu(BuildContext context) => PopupMenuButton<int>(
    itemBuilder: (context) => [
          // PopupMenuItem 1
          PopupMenuItem(
            value: 1,
            // row with 2 children
            child: Row(
              children: [
                Icon(Icons.star),
                SizedBox(
                  width: 10,
                ),
                Text("Get The App",
                    style: TextStyle(
                        color: BlocProvider.of<ThemeBloc>(context)
                            .state
                            .blackColor))
              ],
            ),
          ),
          // PopupMenuItem 2
          PopupMenuItem(
              value: 2,
              // row with two children
              child: Row(
                children: [
                  Icon(Icons.chrome_reader_mode),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "About",
                    style: TextStyle(
                        color: BlocProvider.of<ThemeBloc>(context)
                            .state
                            .blackColor),
                  )
                ],
              )),
        ],
    // offset: Offset(0, 100),
    color: BlocProvider.of<ThemeBloc>(context).state.whiteColor,
    elevation: 2,
    // on selected we show the dialog box
    onSelected: (value) {
      // if value 1 show dialog
      if (value == 2) {
        print("helllllllllllllllll");
        BlocProvider.of<ThemeBloc>(context).add(ChangeThemeEvent());
        // _showDialog(context);
        // if value 2 show dialog
      } else if (value == 1) {
        _showDialog(context);
      }
    },
    // child: Padding(
    //   padding: EdgeInsets.all(8.0),
    //   child: Icon(
    //     Icons.settings_outlined,
    //     color: blackColor,
    //   ),
    child: const Icon(Icons.more_vert, color: greyColor));
