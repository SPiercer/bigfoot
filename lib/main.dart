import 'package:bigfoot/app/modules/splash/splash_screen.dart';
import 'package:bigfoot/color_schemes.g.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          visualDensity: VisualDensity.compact),
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}
