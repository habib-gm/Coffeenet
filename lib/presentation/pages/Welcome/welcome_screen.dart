// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/theme_bloc/bloc/theme_bloc.dart';
import '../../../application/theme_bloc/event/theme_event.dart';
import '../../../application/theme_bloc/state/theme_state.dart';
import 'welcome_screen_imports.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeBloc, ThemeState>(
      listener: (context, state) {
        if (state is InitialThemeState) {
          BlocProvider.of<ThemeBloc>(context).add(LoadThemeEvent());
        }
        ;
      },
      child: SafeArea(
        // child: Responsive(
        // desktop: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Container(
        //         height: MediaQuery.of(context).size.height / 2,
        //         // child: WelcomeImage(),
        //         child: Image.asset(
        //           "assets/wellcome.png",
        //           fit: BoxFit.fitHeight,
        //         )),
        //     Expanded(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: const [
        //           SizedBox(
        //             width: 450,
        //             child: LoginAndSignupBtn(),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        child: Scaffold(
          body: const MobileWelcomeScreen(),
        ),
        // ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // const WelcomeImage(),
        Container(
            height: MediaQuery.of(context).size.height / 1.8,
            child: Image.asset(
              "assets/wellcome.png",
              fit: BoxFit.fitHeight,
            )),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginAndSignupBtn(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
