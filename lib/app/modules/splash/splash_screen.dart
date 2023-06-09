import 'package:bigfoot/app/modules/listing/listing_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  static const link = "https://www.highsnobiety.com/static-assets/thumbor/eEKDSVrNGQS7aopfBVSKVPgxqfE=/1600x2400/www.highsnobiety.com/static-assets/wp-content/uploads/2022/07/27171551/new-balance-thisisneverthat-fw22-collab-003.jpg";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [

          ///
          Image.network(link, fit: BoxFit.fill),

          /// gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.black54,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
          ),

          /// Title top left
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              "Change Your\nPerspective\nIn Style",
              style: TextStyle(
                fontFamily: "Abril Fatface",
                color: Colors.blueGrey[100],
                fontSize: 52,
                letterSpacing: 5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /// lets get started button
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListingScreen()));
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueGrey[100],
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text("Let's Get Started"),
            ),
          ),

        ],
      ),
    );

  }

}
