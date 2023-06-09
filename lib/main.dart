import 'package:bigfoot/app/modules/splash/splash_screen.dart';
import 'package:bigfoot/app/shared/bloc/cart_bloc.dart';
import 'package:bigfoot/color_schemes.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      lazy: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            visualDensity: VisualDensity.compact),
        themeMode: ThemeMode.dark,
        home: const SplashScreen(),
      ),
    );
  }
}
