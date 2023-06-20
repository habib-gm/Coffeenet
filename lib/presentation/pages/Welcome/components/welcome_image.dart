// ignore_for_file: prefer_const_constructors
import 'imports.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Expanded(
            // flex: 8,
            // child: SvgPicture.asset(
            //   "assets/icons/chat.svg",
            // ),
            // child:
            Image.asset(
              "assets/wellcome.png",
              fit: BoxFit.fitHeight,
            )
            // )),
            // Spacer(),
          ],
        ),
        // Text(
        //   "WELCOME TO \n Arabica Armour".toUpperCase(),
        //   textAlign: TextAlign.center,
        //   style: GoogleFonts.rubik(
        //       fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
        // ),
        // SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
