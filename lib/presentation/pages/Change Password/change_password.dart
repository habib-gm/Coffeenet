// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../application/auth_bloc/bloc/change_password_bloc.dart';
import '../../../application/auth_bloc/event/change_password_event.dart';
import '../../../application/auth_bloc/state/change_password_state.dart';
import '../../../application/theme_bloc/bloc/theme_bloc.dart';
import '../../components/app_bar_with_back_buttom.dart';
import '../../constants.dart';
import 'change_password_imports.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarTransparent(context),
        body: BlocConsumer<ChangePasswordBloc, ChangePasswordStates>(
            listener: (context, state) async {
          if (state is LoadingChangePasswordState) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          // TODO: implement listener
          if (state is ChangePasswordSuccessState) {
            await QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              onConfirmBtnTap: () {
                // print("confirm tapped");
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                BlocProvider.of<ChangePasswordBloc>(context)
                    .emit(ChangePasswordInitialState());
              },
              title: 'Success',
              text: 'Your Password has been changed successfully.',
              confirmBtnText: 'Ok',
              confirmBtnColor: Colors.green,
            );
          }
          if (state is ChangePasswordFailedState) {
            await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              onConfirmBtnTap: () {
                // print("confirm tapped");
                Navigator.of(context).pop();
                // Navigator.of(context).pop();
                BlocProvider.of<ChangePasswordBloc>(context)
                    .add(LoadChangePasswordEvent());
              },
              title: 'Error',
              text:
                  'Could not change your password, please check your internet connection or contact the support team if this issue persists to happen.',
              confirmBtnText: 'Retry',
              confirmBtnColor: Colors.red,
            );
          }
        }, builder: (context, state) {
          return SafeArea(
            child: LoaderOverlay(
              overlayColor:
                  BlocProvider.of<ThemeBloc>(context).state.blackColor,
              useDefaultLoading: false,
              overlayWidget: const SpinKitChasingDots(
                color: kPrimaryColor,
                size: 100.0,
              ),
              child: SingleChildScrollView(
                child: Responsive(
                  mobile: const MobileLoginScreen(),
                  desktop: Row(
                    children: [
                      const Expanded(
                        child: ResetPasswordScreenTopImage(),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .9,
                              child: ResetPasswordForm(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const ResetPasswordScreenTopImage(),
        // Row(
        //   children: const [
        // Spacer(),
        // Expanded(
        // flex: 8,
        // child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ResetPasswordForm(),
        ),
        // ),
        // Spacer(),
        // ],
        // ),
      ],
    );
  }
}
