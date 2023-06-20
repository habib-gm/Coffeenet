import '../../../lib.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

// const Landing({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/AICLOGO.png"),
          ),
        ),
      ),
      Container(
        color: const Color.fromRGBO(0, 0, 0, 0.95),
      ),
      const Center(
        child: Image(
          fit: BoxFit.fitWidth,
          image: AssetImage("assets/logo.png"),
        ),
      )

      // Center(child: Image.file(File('images/img.jpg')),)
    ]);
  }
}
