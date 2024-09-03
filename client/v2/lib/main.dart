import 'package:flutter/material.dart';
import 'package:v2/Components/Landing_Page/Landing_page.dart';
import 'package:v2/Components/LoginPage/sign_up.dart';
import 'package:v2/Components/LoginPage/welcome_screen.dart';
import './Components/home_screen/home_screen.dart';
import 'Components/Achivements/achieve_ments.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignupScreen(),
      routes: {
        '/signup': (context) =>
            SignupScreen(), // Define your Homescreen route here
        "/signin": (context) => LoginScreen(),
        "/welcome": (context) => HomeScreen()
      },
    );
  }
}
