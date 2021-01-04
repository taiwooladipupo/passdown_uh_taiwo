import 'package:flutter/material.dart';
import 'package:passdown/views/home.dart';
import 'package:passdown/views/signup.dart';
import 'package:passdown/views/signin.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-signin';
  static const String authRegister = '/auth-signup';
  static const String authHome = '/auth-home';

  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => SignInPage(),
      authRegister: (context) => SignUpPage(),
      authHome: (context) => HomePage(),
    };
  }
}
