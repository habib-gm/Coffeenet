import 'imports.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset("assets/icons/login.svg",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3),
            ),
            const Spacer(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            "LOGIN".toUpperCase(),
            style: GoogleFonts.rubik(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
