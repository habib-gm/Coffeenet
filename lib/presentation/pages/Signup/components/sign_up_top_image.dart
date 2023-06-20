import 'imports.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
            ),
            const Spacer(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            "Sign Up".toUpperCase(),
            style: GoogleFonts.rubik(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
