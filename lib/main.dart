import 'package:bigfoot/app/modules/cart/cart_screen.dart';
import 'package:bigfoot/app/modules/chat/chat_screen.dart';
import 'package:bigfoot/app/modules/listing/listing_screen.dart';
import 'package:bigfoot/app/modules/product/product_screen.dart';
import 'package:bigfoot/app/modules/splash/splash_screen.dart';
import 'package:bigfoot/app/shared/bloc/cart_bloc.dart';
import 'package:bigfoot/color_schemes.g.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
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
          visualDensity: VisualDensity.compact,
        ),
        themeMode: ThemeMode.dark,
        initialRoute:
            FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/sign-in': (context) {
            return SignInScreen(
              providers: [EmailAuthProvider()],
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) async {
                  final user = state.user;
                  if (user == null) return;
                  if (!user.emailVerified) {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Email verification'),
                          content: const Text(
                              'We have sent you an email with a link to verify your account.'),
                          actions: [
                            TextButton(
                              onPressed: Navigator.of(context).pop,
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    await user.sendEmailVerification();
                  }
                  if (context.mounted) {
                    Navigator.of(context).pushReplacementNamed('/listing');
                  }
                }),
              ],
            );
          },
          '/listing': (context) => const ListingScreen(),
          '/product': (context) => const ProductScreen(),
          '/cart': (context) => const CartScreen(),
          '/chat': (context) => const ChatScreen(),
        },
      ),
    );
  }
}
