import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/theme_bloc/bloc/theme_bloc.dart';
import '../../../../infrustructure/auth/repository/auth_repo_imports.dart';

import '../../../../application/theme_bloc/state/theme_state.dart';
import 'imports.dart';

class ResetPasswordScreenTopImage extends StatelessWidget {
  const ResetPasswordScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return Column(
        children: [
          // SizedBox(height: defaultPadding * 2),
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 8,
                child: Image.asset("assets/coffeenet.png",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5),
              ),
              const Spacer(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text(
              "Reset Password".toUpperCase(),
              style: GoogleFonts.rubik(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ),
          Text(
            "please enter your new passsword, make \n sure to use strong password.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: BlocProvider.of<ThemeBloc>(context).state.blackColor),
          ),
          const SizedBox(height: defaultPadding * 2),
        ],
      );
    });
  }
}
