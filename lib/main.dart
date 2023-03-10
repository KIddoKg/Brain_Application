import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brain_application/provider/auth.dart';

import 'package:brain_application/screens/Signin_Screen.dart';
import 'package:brain_application/screens/home/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'general/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Firebase.initializeApp();
  //runApp(const MyApp());

  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    child: MyApp(),
    // overrides: [spProvider.overrideWithValue(sharedPreferences)],
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SigninScreen(),
        // home: futureAuth.when(data: (data) {
        //   return SigninScreen();
        // }, error: (e, st) {
        //   return Scaffold(
        //     body: Center(child: Text(e.toString())),
        //   );
        // }, loading: () {
        //   return Scaffold(
        //     body: Center(child: CircularProgressIndicator()),
        //   );
        // }),
        routes: RouteGenerator.routes,
      );
    });
  }
}
