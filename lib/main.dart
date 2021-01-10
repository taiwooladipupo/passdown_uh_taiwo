import 'package:flutter/material.dart';
import 'package:passdown/views/home.dart';
import 'package:passdown/views/signin.dart';
import 'package:passdown/views/signup.dart';
import 'package:passdown/views/welcome_screen.dart';
//firebase_core: ^0.3.4
//  http: ^0.12.0+4

//Main Class
void main() => runApp(MyApp());


//Class MyApp
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Passdown App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          SignInPage.id: (context) => SignInPage(),
          SignUpPage.id: (context) => SignUpPage(),
          HomePage.id: (context) => HomePage(),
        },
    );
  }
}
