import 'package:flutter/material.dart';
import '../constants.dart';

class ForgetPasswordCheck extends StatelessWidget {
  final Function? press;
  const ForgetPasswordCheck({
    Key? key,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const Text(
          "Forget your password? ",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: const Text(
            "Reset now!",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
